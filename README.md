# GitHub-only AWS Static Website Deployment

This project deploys a private S3-backed static website through CloudFront. All Terraform and deployment commands run in GitHub Actions; no local CLI is required.

## Why there are two workflows

AWS must trust GitHub before GitHub can use OIDC. The first workflow therefore uses temporary AWS credentials one time to create:

- The Terraform state S3 bucket
- The AWS IAM GitHub OIDC provider
- The GitHub Actions Terraform/deployment IAM role

After that, the normal workflow uses GitHub OIDC and temporary AWS role credentials. Delete the temporary bootstrap credentials after confirming that the OIDC workflow succeeds.

## GitHub repository variables

Create these under **Settings → Secrets and variables → Actions → Variables**:

| Variable | Example |
|---|---|
| `AWS_REGION` | `us-east-1` |
| `TF_STATE_BUCKET` | `my-company-static-site-tfstate-12345` |
| `S3_BUCKET_NAME` | `my-company-static-site-12345` |
| `AWS_ACCOUNT_ID` | Your 12-digit AWS account ID; required by the normal deployment workflow |

The bootstrap workflow prints the AWS account ID in its job summary. You can add `AWS_ACCOUNT_ID` after the bootstrap run without using a local CLI.

## Temporary GitHub secrets for bootstrap only

Create these under **Settings → Secrets and variables → Actions → Secrets**:

| Secret | Required |
|---|---|
| `AWS_ACCESS_KEY_ID` | Yes for bootstrap |
| `AWS_SECRET_ACCESS_KEY` | Yes for bootstrap |
| `AWS_SESSION_TOKEN` | Only when using temporary STS credentials |

Use a short-lived or dedicated bootstrap identity. It must be allowed to create/manage the state bucket, the IAM OIDC provider, and the GitHub deployment role.

## Run everything from GitHub

1. Push this repository to GitHub.
2. Configure the variables and temporary secrets above.
3. Open **Actions → Bootstrap AWS OIDC → Run workflow**.
4. Copy the account ID from the workflow summary into the `AWS_ACCOUNT_ID` repository variable.
5. Open **Actions → Terraform and Deploy Static Website → Run workflow**.
6. Confirm the OIDC deployment succeeds.
7. Delete `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_SESSION_TOKEN` from GitHub secrets.

After bootstrap, pushes to `main` automatically run Terraform and publish the website. Pull requests run Terraform formatting, initialization, validation, and planning without applying changes.

## Architecture

```text
Temporary bootstrap secrets (one time)
                 |
                 v
       Bootstrap AWS OIDC workflow
          |             |             |
          v             v             v
   State S3 bucket  OIDC provider  GitHub IAM role
                                      |
                                      v
GitHub push --> OIDC temporary credentials --> Terraform apply
                                      |
                                      v
                         Private S3 + CloudFront
                                      |
                                      v
                                HTTPS website
```
