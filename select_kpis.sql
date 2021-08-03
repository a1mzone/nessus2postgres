-- SELECT ALL TIME 
-- SELECT LAST MONTH
-- CALCULATE RESOLVED

WITH date_time AS (
    SELECT date_trunc('month'::TEXT, CAST(CONCAT('2021', '-', (SELECT key FROM lookup_values lv INNER JOIN lookup_types lt ON lv.type_id = lt.id WHERE lt.name = 'Months' AND lv.value = 'April' ORDER BY lv.key DESC), '-', '01 00:01:00.000') AS TIMESTAMP)) AS start_time,
        (SELECT date_trunc('month'::TEXT, (SELECT date_trunc('month'::TEXT, CAST(CONCAT('2021', '-', (SELECT key FROM lookup_values lv INNER JOIN lookup_types lt ON lv.type_id = lt.id WHERE lt.name = 'Months' AND lv.value = 'April' ORDER BY lv.key DESC), '-', '01 00:1:00.000') AS TIMESTAMP)))) + '1 mon'::INTERVAL - '1 day'::INTERVAL AS end_time)
--     SELECT
--         date_trunc('month'::TEXT, CAST(CONCAT('2020', '-', (SELECT key
--                                                              FROM lookup_values lv
--                                                              INNER JOIN lookup_types lt ON lv.type_id = lt.id
--                                                              WHERE lt.name = 'Months'
--                                                                AND lv.value = 'January'
--                                                              ORDER BY lv.key DESC), '-',
--                                               '01 00:01:00.000') AS TIMESTAMP)) AS start_time,
--  (SELECT date_trunc('month'::TEXT, CAST(CONCAT('$end_year', '-', (SELECT key
--                                                              FROM lookup_values lv
--                                                              INNER JOIN lookup_types lt ON lv.type_id = lt.id
--                                                              WHERE lt.name = 'Months'
--                                                                AND lv.value = '$end_month'
--                                                              ORDER BY lv.key DESC), '-',
--                                               '01 00:01:00.000') AS TIMESTAMP)) + '1 mon'::INTERVAL - '1 day'::INTERVAL AS end_time)
    ),
    scan_id_total_time AS (
        SELECT
--                 row_number()
--                 OVER (PARTITION BY nessus_scans_info.scan_id ORDER BY nessus_scans_info.scan_start DESC) AS cnt,
                nessus_scans_info.history_id
        FROM nessus_scans_info
        INNER JOIN nessus_scans_history nsh ON nessus_scans_info.history_id = nsh.history_id
        WHERE nessus_scans_info.status::TEXT = 'completed'::TEXT
        AND nsh.is_csv_imported = TRUE
        AND nessus_scans_info.scan_start >= date_trunc('month'::TEXT, (SELECT start_time FROM date_time))
        AND nessus_scans_info.scan_start <= (date_trunc('month'::TEXT, (SELECT end_time FROM date_time)) + '1 mon'::INTERVAL - '1 day'::INTERVAL)
    ),
    distinct_vuln_by_host AS (
         SELECT DISTINCT
             host,
             risk,
             name
         FROM nessus_report
         WHERE (nessus_report.history_id IN (SELECT scan_id_total_time.history_id FROM scan_id_total_time))
    ),
    stats AS (
        SELECT
            COUNT(risk),
            risk
--             now() AS TIME
        FROM distinct_vuln_by_host
        GROUP BY risk
        ORDER BY risk
    )
SELECT *
FROM stats;