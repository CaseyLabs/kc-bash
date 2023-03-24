#!/usr/bin/env bash

# USAGE
# ------
# . <(curl -s https://raw.githubusercontent.com/CaseyLabs/kc-bash/main/aws/awsudo.sh)

# Setup AWS cross-account _awsudo_ function.
# Usage: awsudo ${AWS_DEPLOY_ROLE_ARN} aws_cli_cmd_here
awsudo() {
  backupAccessKey=${AWS_ACCESS_KEY_ID}
  backupSecretKey=${AWS_SECRET_ACCESS_KEY}
  backupSessionToken=${AWS_SESSION_TOKEN}
  awsCmd=${@:2}

  # Assume cross-account IAM role, and export credentials to shell:
  export $(printf "AWS_ACCESS_KEY_ID=%s AWS_SECRET_ACCESS_KEY=%s AWS_SESSION_TOKEN=%s" \
  $(aws sts assume-role \
  --role-arn ${1} \
  --role-session-name buildkite-script \
  --query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" \
  --output text))

  # Run provided AWS command with assumed-role credentials:
  eval "${awsCmd}"

  # Restore original AWS credentials:
  AWS_ACCESS_KEY_ID=${backupAccessKey}
  AWS_SECRET_ACCESS_KEY=${backupSecretKey}
  AWS_SESSION_TOKEN=${backupSessionToken}
}
