# AWS_IAM_roles_for_sizing_script
AWS IAM role creation for sizing script

How to run:

```
terraform init
terraform plan
terraform apply
```
Once IAM roles are created, add thease to `~/.aws/config`.
ARN can be gotten from terraform output.

```
[profile management]
role_arn = <ARN for management IAM role>
source_profile = default

[profile member]
role_arn = <ARN for management IAM role>
source_profile = default
```

After IAM role profile is set up, you can run `sizing script` as follows:

**As a management role (for orgs)**

```
python3 sizing.py -o out -p management
```

**As a member role (for account)**

```
python3 sizing.py -o out -p member
```


