# This repo contains instruction to automate GCP Infrastructure for Goldengate DevOps

## Find Expert Connect 1 assignment [here](https://github.com/BiplabAdhikari/GCPTerraform/tree/feature/assignment1)

## Forked repo url [here](https://github.com/BiplabAdhikari/CI-with-Jenkins-in-AWS-Demo)

## Screenshots of the results can be found inside [Assignment1 Artifacts](Assignment1%20Artifacts)

## Make a new file using bash and edit

`touch filename.txt`
`cat >filename.txt`
Press ctrl+D to save
`echo "enter text"> filename.txt`
Append test to file
`echo "append this text">> filename.txt`

## Create the service account in GCP for Terraform admin project and download the JSON credentials

```powershell
gcloud iam service-accounts create terraform \
  --display-name "tfAdmin"

gcloud iam service-accounts keys create ./terraformConfig.json --iam-account terraform@gcpdevops1243852.iam.gserviceaccount.com

gcloud projects add-iam-policy-binding gcpdevops1243852 `
  --member serviceAccount:terraform@gcpdevops1243852.iam.gserviceaccount.com `
  --role roles/compute.admin

```

## Run Terraform

```bash
terraform init
terraform plan
terraform apply
```

## Check startup log in VM

`
sudo journalctl -u google-startup-scripts.service
`

## Check tomcat service status with the following command

`sudo systemctl status tomcat`

## Check jenkins status

`sudo systemctl status jenkins`

## References

[Jenkins Build guide](https://octopus.com/docs/guides/deploy-java-app/to-tomcat/using-octopus-onprem-jenkins-builtin?utm_campaign=&utm_content=&utm_medium=&utm_source=adwords&utm_term=&gclid=Cj0KCQjw9_mDBhCGARIsAN3PaFOedLLKRpSQktqjK1a9TVzYVbZmQo6PCnXianSz_oR7p-t2TnyxDioaArdVEALw_wcB)
