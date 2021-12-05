# DeployAppToCloud
This repository would hold infrastructure as code to be deployed to Azure. This infrastructure would host a Golang application. 

## configs 
- To hold configurations in json format to be used by Terraform resources. 

## infrastructure
- Terraform modules to deploy Azure Kubernetes Services (AKS) cluster infrastructure.
- This cluster would host a Golang application 


## Steps to deploy

### Deploy via local
*Pre-requisites*
- Install terraform CLI (v1.0.11)
- Install AZ CLI
- Need Contributor, User Access Administrator and Reader access to subscription
    - Contributor: To be able to create and manage Azure resources.
    - User Access Administrator: To be able to assign permissions to the cluster managed identities.

*Steps*
- Add subscription_id and tenant_id to configs/infrastructure.tfvars.json - Line 3, 4
- Add tenant id to deployment/secretproviderclass.yaml - Line 20
- terraform init
- terraform apply --var-file "configs/infrastructure.tfvars.json"