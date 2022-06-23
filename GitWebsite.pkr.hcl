
variable "ami" {
  type    = string
  default = "ami-079b5e5b3971bd10d"
}

variable "type" {
  type    = string
  default = "t2.micro"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "Git-Website" {
  ami_name      = "packer-Git-Website ${local.timestamp}"
  instance_type = "${var.type}"
  region        = "ap-south-1"
  source_ami    = "${var.ami}"
  ssh_username  = "ec2-user"
}

build {
  sources = ["source.amazon-ebs.Git-Website"]

  provisioner "shell" {
    script = "/Users/bibin.joy/GolandProjects/bibin/aws/Jenkins-Continuous-Deployment/Git-Script.sh"
  }

  post-processor "shell-local" {
    inline = ["echo AMI Created"]
  }
}
