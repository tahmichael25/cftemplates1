# # Basic Bash Script for Creating an S3 Bucket
# # Here's a simple Bash script to create an S3 bucket named ethbucket1 with write-only permissions:
# #!/bin/bash

# bucket_name="ethbucket1"
# region="us-west-2" # Replace with your desired region

# aws s3 mb s3://$bucket_name --region $region

# # Set bucket policy for write-only access
# bucket_policy='{
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "AllowWriteOnly",
#             "Effect": "Allow",
#             "Principal": "*",
#             "Action": [
#                 "s3:PutObject",
#                 "s3:PutObjectAcl"
#             ]
#         }
#     ]
# }'

# aws s3api put-bucket-policy --bucket $bucket_name --policy "$bucket_policy"



# # Dynamic Bucket Creation
# # To create multiple buckets with sequential numbers, you can incorporate a loop and string manipulation:

# #!/bin/bash

# aws_region="us-west-2"  # Replace with your desired region
# bucket_prefix="ethbucket"
# num_buckets=5
# bucket_policy_file="bucket_policy.json"  # Path to your bucket policy file
# iam_role_arn="arn:aws:iam::your-account-id:role/S3BucketCreationRole"  # Replace with your IAM role ARN
# tags="Environment=Production, CostCenter=1234"  # Replace with your desired tags

# function create_bucket() {
#   bucket_name="$1"
#   policy_file="$2"
#   iam_role="$3"
#   bucket_tags="$4"

#   aws s3 mb s3://$bucket_name --region $aws_region --profile default --role-arn $iam_role

#   # Set bucket policy
#   aws s3api put-bucket-policy --bucket $bucket_name --policy file://$policy_file --profile default --role-arn $iam_role

#   # Enable bucket versioning
#   aws s3api put-bucket-versioning --bucket $bucket_name --VersioningConfiguration Status=Enabled --profile default --role-arn $iam_role

#   # Configure server-side encryption
#   aws s3api put-bucket-encryption --bucket $bucket_name --ServerSideEncryptionConfiguration RuleSet=[{ApplyServerSideEncryptionByDefault={SSEAlgorithm=AES256}}] --profile default --role-arn $iam_role

#   # Set lifecycle configuration (replace with your desired rules)
#   # aws s3api put-bucket-lifecycle-configuration --bucket $bucket_name --LifecycleConfiguration ... --profile default --role-arn $iam_role

#   # Add tags to the bucket
#   aws s3api put-bucket-tagging --bucket $bucket_name --Tagging TagSet=[{Key=Environment, Value=$Environment}, {Key=CostCenter, Value=$CostCenter}] --profile default --role-arn $iam_role

#   # Enable bucket logging (replace with your desired target bucket and prefix)
#   # aws s3api put-bucket-logging --bucket $bucket_name --BucketLoggingStatus={LoggingEnabled={TargetBucket="your-log-bucket", Prefix="access_logs/"}} --profile default --role-arn $iam_role

#   # Configure cross-region replication (replace with your desired destination region and role)
#   # aws s3api put-bucket-replication --bucket $bucket_name --ReplicationConfiguration ... --profile default --role-arn $iam_role

#   # Error handling: Check for successful creation
#   if [ $? -ne 0 ]; then
#     echo "Error creating bucket $bucket_name"
#     exit 1
#   fi
# }

# # Generate unique bucket names (replace with your preferred method)
# for i in $(seq 1 $num_buckets); do
#   bucket_name="${bucket_prefix}-${i}"  # Or use timestamps, UUIDs, etc.
#   create_bucket $bucket_name $bucket_policy_file $iam_role_arn "$tags"
# done



# Key Improvements:
# IAM Roles: Uses the --role-arn flag to specify the IAM role for each AWS CLI command, enhancing security.
# Bucket Tags: Adds tags to buckets using the aws s3api put-bucket-tagging command.
# Bucket Logging: Includes a commented-out example for enabling bucket logging.
# Cross-Region Replication: Includes a commented-out example for configuring cross-region replication.
# Code Organization: Maintains the function-based structure for better readability and maintainability.
# Flexibility: Provides options for customization (e.g., lifecycle rules, encryption algorithms).



# Additional Considerations:
# IAM Role Permissions: Ensure the IAM role has sufficient permissions to perform all the actions in the script.
# Bucket Policy Customization: Tailor the bucket policy to your specific security needs.
# Error Handling: Implement more robust error handling mechanisms to capture specific error messages and retry logic.
# Logging: Consider using a logging library to record script execution details for troubleshooting.
# Testing: Thoroughly test the script in a non-production environment before deploying it to production.
# By incorporating these enhancements, you have a more comprehensive and secure Bash script for creating S3 buckets with advanced features.

# Would you like to customize this script further or explore additional features?