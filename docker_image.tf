# Optional: clone zomato-clone and push to your existing ECR on apply.

resource "null_resource" "push_app_image" {
  triggers = {
    repo    = var.app_github_repo
    ref     = var.app_github_ref
    ecr_url = local.ecr_repository_url
    tag     = var.ecr_image_tag
    region  = var.aws_region
    enabled = tostring(var.build_and_push_image)
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      if [ "${var.build_and_push_image}" != "true" ]; then
        echo "Skipping image build (build_and_push_image=false)"
        exit 0
      fi
      set -eu
      REPO="${var.app_github_repo}"
      REF="${var.app_github_ref}"
      ECR_URL="${local.ecr_repository_url}"
      IMAGE_TAG="${var.ecr_image_tag}"
      REGION="${var.aws_region}"
      REGISTRY="${split("/", local.ecr_repository_url)[0]}"

      WORKDIR=$(mktemp -d)
      trap 'rm -rf "$$WORKDIR"' EXIT

      echo "Cloning https://github.com/$${REPO}.git (ref: $${REF})..."
      git clone --depth 1 --branch "$${REF}" "https://github.com/$${REPO}.git" "$${WORKDIR}/src"

      echo "Logging in to ECR..."
      ECR_PASSWORD=$(aws ecr get-login-password --region "$${REGION}")
      echo "$${ECR_PASSWORD}" | docker login --username AWS --password-stdin "$${REGISTRY}"

      echo "Building and pushing $${ECR_URL}:$${IMAGE_TAG} ..."
      docker build -t "$${ECR_URL}:$${IMAGE_TAG}" "$${WORKDIR}/src"
      docker push "$${ECR_URL}:$${IMAGE_TAG}"
    EOT
  }
}
