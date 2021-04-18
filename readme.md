# Commands

## Make a new file using bash and edit

`touch filename.txt`
`cat >filename.txt`
Press ctrl+D to save
`echo "enter text"> filename.txt`
Append test to file
`echo "append this text">> filename.txt`

## Create the service account in the Terraform admin project and download the JSON credentials

```powershell
gcloud iam service-accounts create terraform \
  --display-name "tfAdmin"

gcloud iam service-accounts keys create ./terraformConfig.json --iam-account terraform@gcpdevops1243852.iam.gserviceaccount.com

gcloud projects add-iam-policy-binding gcpdevops1243852 `
  --member serviceAccount:terraform@gcpdevops1243852.iam.gserviceaccount.com `
  --role roles/compute.admin

```

## Check startup log in VM

`
sudo journalctl -u google-startup-scripts.service
`

## Check the service status with the following command

`sudo systemctl status tomcat`
