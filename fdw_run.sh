#!/bin/sh

# Replace environment variables in the SQL file
envsubst < fdw_setup.sql > fdw_setup_env.sql

# Run the SQL script
echo "Executing FDW setup..."
psql $DATABASE_URL -f fdw_setup_env.sql

echo "FDW setup complete!"
