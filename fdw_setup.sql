-- Enable the postgres_fdw extension
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

-- Create the server connection
CREATE SERVER partner_traffic_server
  FOREIGN DATA WRAPPER postgres_fdw
  OPTIONS (
    host 'shinkansen.proxy.rlwy.net',
    port '21242',
    dbname 'railway'
  );

-- Create a user mapping to connect to the foreign server
CREATE USER MAPPING FOR CURRENT_USER
  SERVER partner_traffic_server
  OPTIONS (
    user 'postgres', 
    password 'nxzNHuvfwPJPUNRbJvTTzrjAARpxFZEY'
  );

-- Create a schema to contain the foreign tables
CREATE SCHEMA IF NOT EXISTS traffic_data;

-- Import foreign schema (adjust table names as needed based on partner's database)
IMPORT FOREIGN SCHEMA public 
  LIMIT TO (traffic_flow, locations)
  FROM SERVER partner_traffic_server 
  INTO traffic_data;

-- Grant access permissions for PostgREST api schema
GRANT USAGE ON SCHEMA traffic_data TO web_anon;
GRANT SELECT ON ALL TABLES IN SCHEMA traffic_data TO web_anon;

-- Create views in the api schema
CREATE OR REPLACE VIEW api.traffic_data AS
  SELECT * FROM traffic_data.traffic_flow;

CREATE OR REPLACE VIEW api.traffic_locations AS
  SELECT * FROM traffic_data.locations;

-- Test query (uncomment to verify)
-- SELECT * FROM traffic_data.traffic_measurements LIMIT 5;
