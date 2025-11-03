provider "aws" {
  region     = var.region
  default_tags {
    tags = {
      Project     = var.my_project_name
      Environment = var.my_project_env
    }
  }
}

