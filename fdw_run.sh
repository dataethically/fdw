#!/bin/sh

# Run the SQL script
echo "Executing FDW setup..."
psql $DATABASE_URL -f fdw_setup.sql

echo "FDW setup complete!"
