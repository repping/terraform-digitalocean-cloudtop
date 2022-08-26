# Support code

Run the Terraform code in this folder before creating the Cloudtop. Use the outputs as inputs for the Cloudtop deployment.

Infrastucture in this folder is also ment to persist when the Cloudtop infrastructure from the root module is destroy.
i.e. the /home volume WITH the user data is not destroy so it can be reused when the Cloudtop is redeployed in the future.
