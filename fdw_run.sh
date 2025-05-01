#!/bin/sh

# Run the SQL script
echo "Executing FDW setup..."
psql $DATABASE_URL -f fdw_setup_env.sql

echo "FDW setup complete!"
