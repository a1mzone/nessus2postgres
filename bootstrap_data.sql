-- NESSUS INTEGRATION
-- TABLES BOOTSTRAP DATA FOR PORTGRESQL
-- ZAKK COETZEE -> 2020

INSERT INTO public.lookup_types (id, name, deleted) VALUES (1, 'Days', false);
INSERT INTO public.lookup_types (id, name, deleted) VALUES (2, 'Severity', false);
INSERT INTO public.lookup_types (id, name, deleted) VALUES (3, 'Months', false);

INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (1, 1, 'MO', 'Monday', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (2, 1, 'TU', 'Tuesday', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (3, 1, 'WE', 'Wednesday', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (5, 1, 'FR', 'Friday', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (6, 1, 'SA', 'Saturday', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (7, 1, 'SU', 'Sunday', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (4, 1, 'TH', 'Thursday', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (8, 2, '5', 'Critical', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (9, 2, '4', 'High', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (10, 2, '3', 'Medium', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (11, 2, '2', 'Low', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (12, 2, '1', 'Info', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (13, 2, '0', 'Debug', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (15, 3, '02', 'February', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (16, 3, '03', 'March', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (17, 3, '04', 'April', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (14, 3, '01', 'January', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (19, 3, '06', 'June', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (21, 3, '08', 'August', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (20, 3, '07', 'July', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (18, 3, '05', 'May', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (22, 3, '09', 'September', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (23, 3, '10', 'October', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (24, 3, '11', 'November', false);
INSERT INTO public.lookup_values (id, type_id, key, value, deleted) VALUES (25, 3, '12', 'December', false);

INSERT INTO public.nessus_sessions (id, access_token, secret_token, modified_on) VALUES (1, '', '', null);

