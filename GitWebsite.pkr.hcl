variable "access_key" {
  type    = string
  default = "AKIAZ2DY7YXZJJE4QP4I"
}

variable "secret_key" {
  type    = string
  default = "AoBp7zll/tthz1jiOQoS4wE2m9c/utuivGB7cuh7"
}
    
variable "ami" {
  type    = string
  default = "ami-052cef05d01020f1d"    
}

variable "type" {
  type    = string
  default = "t2.micro" 
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "Git-Website" {
  access_key    = "${var.access_key}"
  ami_name      = "packer-Git-Website ${local.timestamp}"
  instance_type = "${var.type}"
  region        = "ap-south-1"
  secret_key    = "${var.secret_key}"
  source_ami    = "${var.ami}"
  ssh_username  = "ec2-user"
}

build {
  sources = ["source.amazon-ebs.Git-Website"]
  
  provisioner "shell" {
    script = "/var/Jenkins-Continuous-Deployment/Git-Script.sh"
  }

  post-processor "shell-local" {
    inline = ["echo AMI Created"]
  }
}
