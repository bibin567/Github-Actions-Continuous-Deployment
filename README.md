![](https://visitor-badge.laobi.icu/badge?page_id=jwenjian.visitor-badge)

# Jenkins-Continuous-Deployment
Jenkins continuous deployment for Git based website/App with Packer, Terraform and Ansible. 

# Description

Here I have created a sample Jenkins Continuous Deploymnet Pipeline with Git Website, Packer, Terraform and Ansible. The work flow is described below,

1. Developer commits changes to Git Repository
2. The Git webhook will alert Jenkins regarding the commit and the Pipeline starts
3. First Job in pipeline is creating the Golden image of the current website/app using [Packer](https://www.packer.io/)
4. Once the AMI creation is done successfully the next Job will be automatically triggered. In this step the [Terraform](https://www.terraform.io/) will create following infrastucture in AWS
    a) Application Load Balancer
    b) Target Group for ALB
    c) Https Listner and http to https redirection
    d) Security Group
    e) Launch Configuration with Packer Golden image
    f) Auto Scaling Group with the Launch Configuration.
5. Once second job is completed successfully the third one starts, which is offloading and adding new website contents to the instances. This is done using [Ansible](https://www.ansible.com/). In this job, the ansible will offload the instances one by one ensuring that there is no downtime for the website. By doing this we can avoid unnecessary termination of old instances from ASG and change the contents of current instances itself. This job will be skipped in the first run since the contents are same. 

Below, I have included a simple diagram showing this CD pipeline,

![image](https://user-images.githubusercontent.com/88414576/144723867-3f98fde6-ca33-4b2d-8ba5-5a9e16f0c0cf.png)


## How to use

##### Prerequisites

- Git, Terraform, Ansible, Packer and jenkins installed on the master server. 
- All necessary dependencies for these tools.
- One AWS key pair created
- ARM of ACM certificate created/imported in AWS
- IAM use with necessary progamatic access. 
- Domain name and Git repo with website/App files.

##### Files to edit

- autoscaling_vars.yml (Variable file for Ansible)
- Git-Script.sh  (Script for Packer - Enter the Git URL)
- terraform.tfvars (Variable file for Terraform) 
- GitWebsite.pkr.hcl (Edit the variables section) 

```
cd /var 
git clone https://github.com/MarkAntonyGit/Jenkins-Continuous-Deployment.git
Chown -R jenkins. Jenkins-Continuous-Deployment
cd Jenkins-Continuous-Deployment 
# Edit the above mentioned files and add key pem file with 600 permission and jenkins ownership
Setup Jenkins with Ansible, Teraform, Packer, Deployment pipeline plugins and Create 3 jobs for pipeline
Setup Webhook for the Git Repository
``` 

This is it! 
Once any commits are done on the Git repository the Jenkins will be triggered and the pipeline will start automatically. 

#### Sample Screenshots

-- Git Hub Webhook

![image](https://user-images.githubusercontent.com/88414576/144724329-2ed6a18e-379b-4aa5-9711-7b092c508043.png)


-- Jenkins Pipeline

![image](https://user-images.githubusercontent.com/88414576/144724323-3a0d146c-e5b4-4da8-bcef-013319071a42.png)

-- Git Website Version 1


### Connect with me

--------<img src="https://img.shields.io/badge/-Bibin%20Joy-brightgreen"/> ----------------------------------------------------------------------------------------------------------------------------------- <a href="https://www.linkedin.com/in/bibin-joy-4b0877a0/"><img src="https://img.shields.io/badge/-Linkedin%20Profile-blue"/></a> ------------------------------------------------------------------------------------------------------------------------------------ <a href="mailto:bibinjoy2255@gmail.com">
