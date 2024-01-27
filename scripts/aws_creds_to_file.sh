#!/bin/bash

# Check if a profile name is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <profile-name>"
    exit 1
fi

# Assign the first argument to a variable
PROFILE_NAME=$1

# Export credentials and format them
aws configure export-credentials --profile "$PROFILE_NAME" --format env-no-export | \
grep -E 'AWS_ACCESS_KEY_ID|AWS_SECRET_ACCESS_KEY|AWS_SESSION_TOKEN' | \
sed -e 's/AWS_ACCESS_KEY_ID/aws_access_key_id/' \
    -e 's/AWS_SECRET_ACCESS_KEY/aws_secret_access_key/' \
    -e 's/AWS_SESSION_TOKEN/aws_session_token/' \
    -e 's/^/ /' -e 's/=/ =/' | \
awk -v profile="default" 'BEGIN {print "["profile"]"} {print}' > ~/.aws/credentials

echo "Credentials for $PROFILE_NAME have been exported to ~/.aws/credentials"

