<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://i.imgur.com/6wj0hh6.jpg" alt="Project logo"></a>
</p>

<h3 align="center">Terraform by Vadym Zghonnyk</h3>

<div align="center">

<!-- [![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/kylelobo/The-Documentation-Compendium.svg)](https://github.com/kylelobo/The-Documentation-Compendium/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/kylelobo/The-Documentation-Compendium.svg)](https://github.com/kylelobo/The-Documentation-Compendium/pulls)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE) -->

</div>

---

<p align="center"> 
    <br> 
    Learn terraform 
</p>

<!-- ## 📝 Table of Contents -->

<!-- - [About](#about)
- [Getting Started](#getting_started)
- [Deployment](#deployment)
- [Usage](#usage)
- [Built Using](#built_using)
- [TODO](../TODO.md)
- [Contributing](../CONTRIBUTING.md)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement) -->

<!-- ## 🧐 About <a name = "about"></a>

Write about 1-2 paragraphs describing the purpose of your project. -->

<!-- ## 🏁 Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [deployment](#deployment) for notes on how to deploy the project on a live system. -->

### Prerequisites

What things you need to install the software and how to install them.

Terraform 

```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```
```
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
```
```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```
```
sudo apt update
```

```
sudo apt-get install terraform
```
For see all comand 
```
terraform -help
```


### Installing and running

A step by step series of examples that tell you how to get a development env running.

Init project

```
terraform init
```

Before running, you need to create a secrets.tfvars file and add the following fields to it 

```
db_username = "example"
```

```
db_password=""example
```

```
my_ip="x.x.x.x"
```

Creating the Key Pair

We will be creating a new key pair in our terraform directory. Run the following command:

```
ssh-keygen -t rsa -b 4096 -m pem -f tutorial_kp && openssl rsa -in tutorial_kp -outform pem && chmod 400 tutorial_kp.pem
```

Run prbuild

```
terraform plan -var-file="secrets.tfvars"
```

Run terraform

```
terraform apply 
```

For ssh conect use

```
ssh -i "tutorial_kp.pem" ubuntu@$(terraform output -raw web_public_dns)
```

or 

```
ssh -o 'IdentitiesOnly yes' -i "tutorial_kp.pem" ubuntu@$(terraform output -raw web_public_dns)
```

```
npm install -g pnpm
```

<!-- End with an example of getting some data out of the system or using it for a little demo.

## 🔧 Running the tests <a name = "tests"></a>

Explain how to run the automated tests for this system.

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
``` -->

<!-- ### And coding style tests

Explain what these tests test and why

```
Give an example
```

## 🎈 Usage <a name="usage"></a>

Add notes about how to use the system.

## 🚀 Deployment <a name = "deployment"></a>

Add additional notes about how to deploy this on a live system.

## ⛏️ Built Using <a name = "built_using"></a>

- [MongoDB](https://www.mongodb.com/) - Database
- [Express](https://expressjs.com/) - Server Framework
- [VueJs](https://vuejs.org/) - Web Framework
- [NodeJs](https://nodejs.org/en/) - Server Environment

## ✍️ Authors <a name = "authors"></a>

- [@kylelobo](https://github.com/kylelobo) - Idea & Initial work

See also the list of [contributors](https://github.com/kylelobo/The-Documentation-Compendium/contributors) who participated in this project.

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- Hat tip to anyone whose code was used
- Inspiration
- References -->
