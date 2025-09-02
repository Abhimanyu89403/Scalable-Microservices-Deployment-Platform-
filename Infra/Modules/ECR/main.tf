resource "aws_ecr_repository" "my_ecr" {
    name = "user_services"
    image_tag_mutability = "Immutable"
    image_scanning_configuration {
        scan_on_push = true
    }
}