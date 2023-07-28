# Kafka Demo - Infrastructure

Simple IaC used to create and manage the Azure infrastructure for my Kafka demo project.

The repo containing the demo's artefacts can be found here.

## Description:
Whilst working on this personal project, I wished to achieve the following goals:
 - Employ Terraform best practices
 - Utilise modules to create flexible resuable infrastructure
 - Remote Terraform backend via Azure Storage Accounts
 - Deployed via Azure Service Principal
 - Deploy Artefacts via Ansible
 - Implement Kafka via Azure Container Instances
 - Develop & demonstrate my skills with both Python (Flask) & JavaScript (Node.js, KafkaJS)
 - Create demo consumer & producer applications with various programming & scriping languages
 - Develop & implement demo web app for use with Kafka
 - Connect Kafka instance with a relational database.

## Cloud Infrastructure Diagram:

## Service Principle
The service principle used by GitHub Actions must be assigned both contributer and Key Vault Administrator. Without Key Vault Administrator Terraform will be unable to destroy or make changes to deployments which include the Key Vault.

## Terraform Backend
