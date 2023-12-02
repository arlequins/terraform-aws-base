```
tfenv install
terraform -chdir=terraform/ init -reconfigure -backend=false
terraform -chdir=terraform/ validate
tflint
tfsec
terraform-docs markdown --output-file README.md ./
terraform -chdir=terraform/ plan
```
