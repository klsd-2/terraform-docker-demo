# terraform-docker-demo — Infrastructure as Code with Terraform

Provisions a local **nginx Docker container** using Terraform and the Docker provider.

## Tools
Terraform, Docker Desktop

## Files
| File | Purpose |
|------|---------|
| `main.tf` | Provider, image, container, variables and outputs |
| `logs/` | Saved output of `terraform init`, `plan`, `apply`, `state`, `destroy` |
| `screenshots/` | Proof of the container running |

## Commands run
```bash
terraform init      # download the Docker provider
terraform validate  # check the syntax
terraform plan      # preview the changes
terraform apply     # create the container
terraform state list
terraform state show docker_container.nginx
terraform destroy   # remove everything
```

## Result
After `terraform apply`, nginx is available at http://localhost:8080.
`terraform destroy` removes the container and the image.

## Notes
- The `.terraform/` folder and state files are not committed (see `.gitignore`).
- Docker host on Windows: `npipe:////./pipe/docker_engine`. On Linux/macOS override with
  `-var="docker_host=unix:///var/run/docker.sock"`.
