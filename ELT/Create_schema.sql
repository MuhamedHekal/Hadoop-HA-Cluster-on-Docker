-- run this file as a sys user
CREATE USER airline_op IDENTIFIED BY airline;

GRANT CREATE MATERIALIZED VIEW,
      CREATE PROCEDURE,
      CREATE SEQUENCE,
      CREATE SESSION,
      CREATE SYNONYM,
      CREATE TABLE,
      CREATE TRIGGER,
      CREATE TYPE,
      CREATE VIEW
  TO airline_op;

ALTER USER airline_op QUOTA UNLIMITED ON USERS;

--drop user airline_op CASCADE;