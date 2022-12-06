# https://brendanthompson.com/posts/2022/01/how-to-use-terraform-remote-backends
# https://brendanthompson.com/posts/2021/10/dynamic-terraform-backend-configuration 



terraform {
  cloud {
    organization = "ya3"
    workspaces {
      name = "az-statis-web"
    }
  }


  # # use remote state.. 
  # run the hcl file with 
  # terraform init -backend-config=backend.hcl command
  # backend "remote" {
  #       }


  # # us this local block for local allocation... 
  # backend "local" {
  #     workspace_dir = "./env/t4-state"
  #     path = "dev.tfstate"
  # }
}
