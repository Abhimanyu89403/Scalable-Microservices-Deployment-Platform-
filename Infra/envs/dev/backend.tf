terraform {
  backend "s3"{
    bucket  = "my-state-file-bucket"
    key = "microservices/dev/terraform.tfstate"  //path to store the state files
    region = "ap-south-1"
    dynamodb_table = "tf-locks"  //for state locking
    encrypt = true //state file is encrypted at rest
  }
}