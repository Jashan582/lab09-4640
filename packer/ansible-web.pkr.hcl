packer {
  required_plugins {
    amazon = {
      version = "1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = "1.1.2"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-ansible-nginx"
  instance_type = "t2.micro"
  region        = "us-west-2"

  source_ami_filter {
    filters = {
      name = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }

  ssh_username = var.ssh_username
}

build {
  name = "web-nginx"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt-get install -y ansible"
    ]
  }

 
  provisioner "ansible-local" {
    playbook_file   = "/mnt/c/Users/dosan/4640-w9-lab-start-w25//ansible/playbook.yml"
    playbook_dir    = "/mnt/c/Users/dosan/4640-w9-lab-start-w25/ansible"
    ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False"]
    extra_arguments = ["-vvv"]
  }


  provisioner "shell" {
    inline = [
      "sudo rm -rf /tmp/web",
      "sudo systemctl reload nginx",
      "echo 'Build completed successfully'"
    ]
  }
}

