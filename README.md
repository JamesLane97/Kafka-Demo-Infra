# Kafka Demo - Infrastructure

[![Terraform Plan/Apply](https://github.com/JamesLane97/Kafka-Demo-Infra/actions/workflows/tf-plan-apply.yml/badge.svg)](https://github.com/JamesLane97/Kafka-Demo-Infra/actions/workflows/tf-plan-apply.yml)

Simple IaC used to create and manage the Azure infrastructure for my Kafka demo project.

The repo containing the demo's artefacts can be found here.

## Description:

Project Goals:
 - Employ Terraform & Azure best practices
 - Utilise modules to create flexible resuable infrastructure
 - Remote Terraform backend via Azure Storage Accounts
 - Deployed via Azure Service Principal
 - Deploy Artefacts via Ansible
 - Implement Kafka via Containers, preferably with custom built images
 - Develop & demonstrate my skills with both Python (Flask) & JavaScript (Node.js, KafkaJS)
 - Develop & implement demo web app for use with Kafka
 - Connect Kafka instance with a relational database.

## Infrastructure Diagram:
![Infrastructure Diagram](https://i.imgur.com/EhKLdnQ.png)

## Service Principle
The service principle used by GitHub Actions must be assigned both contributer and Key Vault Administrator. Without Key Vault Administrator Terraform will be unable to destroy or make changes to deployments which include the Key Vault.
