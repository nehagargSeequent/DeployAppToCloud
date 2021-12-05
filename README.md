# DeployAppToCloud
This repository holds terraform resources to create infrastructure to host a Golang application. 

## configs 
- **backend.tfvars.json**: To hold backend configuration to be used to create and access terraform state.
- **infrastructure.tfvars.json**: To hold configurations in json format to be used by Terraform resources. 

## infrastructure
- Terraform configuration to deploy Azure Kubernetes Services (AKS) cluster infrastructure.
- Terraform module to deploy PostgreSQL server infrastructure.
- This cluster would host a Golang application 

## deployment
- This folder has Kubernetes manifests.
- Go through [INSTRUCTIONS](https://github.com/nehagargSeequent/DeployAppToCloud/blob/main/INSTRUCTIONS.md) to deploy your app to this infrastructure.

## .github/workflows/deploy_app.yml
- Github workflow need to create AKS cluster, PostgreSQL server and to deploy app to the cluster.

## High-level Architecture Overview


