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