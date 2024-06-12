DROP TABLE IF EXISTS logging;
CREATE TABLE logging (
    id BIGSERIAL PRIMARY KEY,
    logLevel int,
    datetime VARCHAR(20),
    other VARCHAR(256)
);

INSERT INTO logging (logLevel, datetime, other)
SELECT
    (RANDOM() * 8)::int,
    'Nov 10 ' || LPAD(FLOOR(RANDOM() * 23)::text, 2, '0') || ':13:56',
    (ARRAY['fccd8a5f3a42,rsyslogd-2007:,action -action 9- suspended, next retry is Fri Oct 26 13:54:37 2018 [v8.16.0 try http://www.rsyslog.com/e/2007 ]',
           'fccd8a5f3a42,rsyslogd:,rsyslogds userid changed to 107'])[FLOOR(RANDOM() * 2 + 1)]
FROM generate_series(1, 200) s(i);