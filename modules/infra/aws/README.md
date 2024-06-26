# Terraform | AWS - Preparatory steps

In order for Terraform to run operations on your behalf, you must [install and configure the AWS CLI tool](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions).

## Example

#### macOS installation and setup for all users

```console
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
```

```console
sudo installer -pkg AWSCLIV2.pkg -target /
```

#### Verify installation

```console
$ which aws
/usr/local/bin/aws
```

```console
$ aws --version
aws-cli/2.13.33 Python/3.11.6 Darwin/23.1.0 exe/x86_64 prompt/off
```

#### Setup credentials and configuration

##### Option 1 - AWS CLI

```console
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_DEFAULT_REGION=
export AWS_DEFAULT_OUTPUT=text
```

##### Option 2 - Manually creating credential files

```console
mkdir ~/.aws
```

```console
cd ~/.aws
```

```console
cat > credentials << EOL
[default]
aws_access_key_id = <YOUR_ACCESS_KEY>
aws_secret_access_key = <YOUR_SECRET_ACCESS_KEY>
EOL
```

```console
cat > config << EOL
[default]
region = <REGION>
output = text
EOL
```

##### Option 3 - IAM Identity Center credentials

```console
aws configure sso
```

```console
export AWS_PROFILE=<YOUR_CONFIG_PROFILE>
```

##### Verify credentials
```console
aws sts get-caller-identity
```
