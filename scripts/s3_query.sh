#!/bin/bash

# Execute query in DuckDB with AWS credentials loaded
[ "$#" -eq 1 ] && duckdb -c "CALL load_aws_credentials(); $1" || echo "Usage: $0 'your_query_here'"
