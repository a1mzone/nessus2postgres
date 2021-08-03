-- NESSUS INTEGRATION
-- TABLES BOOTSTRAP FOR PORTGRESQL
-- ZAKK COETZEE -> 2020


CREATE TABLE lookup_values
(
    id           INTEGER GENERATED ALWAYS AS IDENTITY,
    type_id      INTEGER,
    key          VARCHAR(100),
    value        VARCHAR(100),
    deleted      BOOLEAN   DEFAULT FALSE,
    date_created TIMESTAMP DEFAULT now()
);

ALTER TABLE lookup_values
    OWNER TO nessus_svc;

CREATE TABLE nessus_sessions
(
    id           SERIAL NOT NULL
        CONSTRAINT pk_sess_id
            PRIMARY KEY,
    access_token VARCHAR(150),
    secret_token VARCHAR(150),
    modified_on  TIMESTAMP,
    date_created TIMESTAMP DEFAULT now()
);

ALTER TABLE nessus_sessions
    OWNER TO nessus_svc;

CREATE TABLE lookup_types
(
    id      SERIAL NOT NULL
        CONSTRAINT pk_id_luv
            PRIMARY KEY,
    name    VARCHAR(100),
    deleted BOOLEAN DEFAULT FALSE
);

ALTER TABLE lookup_types
    OWNER TO nessus_svc;

CREATE TABLE nessus_vulnerabilities
(
    id             INTEGER GENERATED ALWAYS AS IDENTITY,
    history_id     BIGINT,
    plugin_id      BIGINT,
    plugin_name    VARCHAR(200),
    severity       INTEGER,
    severity_index INTEGER,
    vul_count      INTEGER
);

ALTER TABLE nessus_vulnerabilities
    OWNER TO nessus_svc;

CREATE TABLE nessus_report
(
    id         INTEGER GENERATED ALWAYS AS IDENTITY
        CONSTRAINT pk_id
            PRIMARY KEY,
    history_id BIGINT,
    plugin_id  BIGINT,
    cve        VARCHAR(100),
    cvss       VARCHAR(20),
    risk       VARCHAR(100),
    host       VARCHAR(50),
    protocol   VARCHAR(50),
    port       INTEGER,
    name       VARCHAR(200),
    synopsis   VARCHAR(512)
);

ALTER TABLE nessus_report
    OWNER TO nessus_svc;

CREATE INDEX idx_no_dupes
    ON nessus_report (history_id, host, cve);

CREATE INDEX idx_host_risk_name
    ON nessus_report (host, risk, name);

CREATE TABLE nessus_folders
(
    id        INTEGER GENERATED ALWAYS AS IDENTITY,
    name      VARCHAR(150),
    folder_id INTEGER NOT NULL
        CONSTRAINT pk_folder_id
            PRIMARY KEY
);

ALTER TABLE nessus_folders
    OWNER TO nessus_svc;

CREATE TABLE nessus_scans
(
    id           INTEGER GENERATED ALWAYS AS IDENTITY,
    name         VARCHAR(150),
    scan_id      INTEGER NOT NULL
        CONSTRAINT pk_
            PRIMARY KEY
        CONSTRAINT scan_id_unique
            UNIQUE,
    folder_id    INTEGER,
    start_time   TIMESTAMP,
    modified_on  TIMESTAMP,
    date_created TIMESTAMP,
    status       VARCHAR(50),
    enabled      BOOLEAN,
    frequency    VARCHAR(50),
    interval     INTEGER,
    days         VARCHAR(100)
);

ALTER TABLE nessus_scans
    OWNER TO nessus_svc;

CREATE TABLE nessus_scans_history
(
    id              INTEGER GENERATED ALWAYS AS IDENTITY,
    scan_id         INTEGER,
    history_id      INTEGER
        CONSTRAINT history_id_unique
            UNIQUE,
    status          VARCHAR(50),
    is_imported     BOOLEAN DEFAULT FALSE,
    is_csv_imported BOOLEAN DEFAULT FALSE,
    is_empty        BOOLEAN
);

ALTER TABLE nessus_scans_history
    OWNER TO nessus_svc;

CREATE TABLE nessus_scans_info
(
    id         INTEGER GENERATED ALWAYS AS IDENTITY,
    scan_id    INTEGER,
    folder_id  INTEGER,
    history_id INTEGER NOT NULL
        CONSTRAINT pk_hid
            PRIMARY KEY,
    name       VARCHAR(100),
    status     VARCHAR(50),
    scan_start TIMESTAMP,
    scan_end   TIMESTAMP,
    hosts      VARCHAR(1000)
);

ALTER TABLE nessus_scans_info
    OWNER TO nessus_svc;

CREATE TABLE nessus_scans_host_metric
(
    id         SERIAL NOT NULL
        CONSTRAINT pk_shm
            PRIMARY KEY,
    history_id INTEGER,
    critical   INTEGER,
    high       INTEGER,
    medium     INTEGER,
    low        INTEGER,
    info       INTEGER,
    hostname   VARCHAR(100)
);

ALTER TABLE nessus_scans_host_metric
    OWNER TO nessus_svc;

CREATE UNIQUE INDEX idx_unique
    ON nessus_scans_host_metric (hostname, history_id);

