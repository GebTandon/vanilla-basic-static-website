# Vanilla JavaScript App


[Azure Static Web Apps](https://docs.microsoft.com/azure/static-web-apps/overview) allows you to easily build JavaScript apps in minutes. Use this repo with the [quickstart](https://docs.microsoft.com/azure/static-web-apps/getting-started?tabs=vanilla-javascript) to build and customize a new static site.

This repo is used as a starter for a _very basic_ HTML web application using no front-end frameworks.
 - [app service](https://www.cloudiqtech.com/deploy-a-web-app-in-azure-app-service-using-terraform/ )
 - [example w/ terraform](https://medium.com/bb-tutorials-and-thoughts/how-to-create-a-static-website-on-azure-with-terraform-9971e55e2884 )^^not useful^^


 # Terraform
 - [T4-Cloud Adoption Framework (templates)](https://github.com/aztfmod/terraform-azurerm-caf )
 - prepare Az account as here - https://stackoverflow.com/questions/72681536/azure-cli-path-error-running-in-terraform-cloud
- [locals](https://spacelift.io/blog/terraform-locals )
 - use terraform login to login to t4 and get t4 login token. Set this token at global level
 - [follow](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal-using-the-azure-cli ) to set correct azure context and create an SP that allows T4 to create all resources in AZ.
- [debugging](https://www.jorgebernhardt.com/terraform-troubleshooting-logging/ )

```shell
# t4 command to run
$> TF_LOG=TRACE terraform init
$> TF_LOG=TRACE terraform plan
$> TF_LOG=TRACE terraform apply
$> TF_LOG=TRACE terraform destroy

```