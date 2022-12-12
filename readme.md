# Vanilla JavaScript App


[Azure Static Web Apps](https://docs.microsoft.com/azure/static-web-apps/overview) allows you to easily build JavaScript apps in minutes. Use this repo with the [quickstart](https://docs.microsoft.com/azure/static-web-apps/getting-started?tabs=vanilla-javascript) to build and customize a new static site.

This repo is used as a starter for a _very basic_ HTML web application using no front-end frameworks.
 - [app service](https://www.cloudiqtech.com/deploy-a-web-app-in-azure-app-service-using-terraform/ )
 - [example w/ terraform](https://medium.com/bb-tutorials-and-thoughts/how-to-create-a-static-website-on-azure-with-terraform-9971e55e2884 )^^not useful^^


 # Terraform
 - [Configure for Azure](https://registry.terraform.io/providers/hashicorp/azurerm/2.35.0/docs/guides/service_principal_client_secret#configuring-the-service-principal-in-terraform )
 - [T4-Cloud Adoption Framework (templates)](https://github.com/aztfmod/terraform-azurerm-caf )
 - prepare Az account as here - https://stackoverflow.com/questions/72681536/azure-cli-path-error-running-in-terraform-cloud
- [locals](https://spacelift.io/blog/terraform-locals )
 - use terraform login to login to t4 and get t4 login token. Set this token at global level
 - [follow](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal-using-the-azure-cli ) to set correct azure context and create an SP that allows T4 to create all 
 resources in AZ. or follow commands below:
 ```shell
 $> az login
 $> az account list
 $> az account set --subscription="0a29e980-4c21-4962-95d2-2bf201b2e927"
 ```
    
- [debugging](https://www.jorgebernhardt.com/terraform-troubleshooting-logging/ )

```shell
# t4 command to run
$> TF_LOG=TRACE terraform init
$> TF_LOG=TRACE terraform plan
$> TF_LOG=TRACE terraform apply
$> TF_LOG=TRACE terraform destroy

```

- [importing existing resources](https://marcelzehner.ch/2020/07/04/how-to-bring-existing-azure-resources-under-terraform-management/ ) can be done.
    note, that since this command runs locally on the machine importing resources, the remote variable values do not work (especially secrets)
    so we do need to provide those values in a *.auto.tfvars, and do not checkin this file after import is over.
    - Terraform import can only import resources into the state. It does not generate configuration.
    - hence after import, its necessary to run plan and apply to sync the .tf files
    - [video](https://www.youtube.com/watch?v=VNBi-HhVX_Q )
    - How to do import (Its a very critical operation, and things may go wrong at times.)
        - to minimize impact, import least amount of resources in a go.
        - communicate before starting import with team members
        - cut CI/CD pipeline temporarily, so resources are not changed while import happens
            -  from TF remote state, disable auto update & remove reference to pipeline/config mgt tool
    - Run the plan command and update the terraform tf files manually so that the resources are not replaced, only updated. (in fact try to get to point where it does not want to change anything, that will make sure code is in sync with actual resource).
    - THIS IS LABOUR INTENSIVE PROCESS DO NOT ATTEMPT IF NOT NEEDED!!
    
```shell
# sample command run to import/sync updates to the webapp was as follows 
$> t4 import azurerm_linux_web_app.webapp "/subscriptions/0a29e980-4c21-4962-95d2-2bf201b2e927/resourceGroups/rg-stc-web/providers/Microsoft.Web/sites/stc-webapp-6634av"
```

## Issues ##
### With Azure ###
- [WSL](https://github.com/microsoft/WSL/issues/8022 )