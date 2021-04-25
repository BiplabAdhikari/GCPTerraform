# This repo contains instruction to automate GCP Infrastructure for Goldengate DevOps

## Find Expert Connect 1 assignment [here](https://github.com/BiplabAdhikari/GCPTerraform/tree/feature/assignment1)

## Forked repo url [here](https://github.com/BiplabAdhikari/CI-with-Jenkins-in-AWS-Demo)

## Screenshots of the assignment 1 can be found inside [Assignment1 Artifacts](Assignment1%20Artifacts)

## Screenshots of the assignment 2 can be found inside [Assignment1 Artifacts](Assignment2%20Artifacts)

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

## Jenkins build pipeline configuration

Maven Goals
`versions:set -DnewVersion=1.0.$BUILD_NUMBER`
`clean test package`

Deploy
`**/*.war`

## Issues

Error `/bin/bash^M: bad interpreter: No such file or directory`

The script indicates that it must be executed by a shell located at /bin/bash^M. There is no such file: it's called /bin/bash.

The ^M is a carriage return character. Linux uses the line feed character to mark the end of a line, whereas Windows uses the two-character sequence CR LF. Your file has Windows line endings, which is confusing Linux.

Remove the spurious CR characters. You can do it with the following command:

`sed -i -e 's/\r$//' install_jenkins.sh`

Error `TomcatManagerException: The username you provided is not allowed to use the text-based Tomcat Manager (error 403)`

Enter sudo mode using below command
`sudo su`

Open below file in edit mode
`vim nano /opt/tomcat/webapps/manager/META-INF/context.xml`

```xml
<Context antiResourceLocking="false" privileged="true" >
  <!--<Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />-->
</Context>
```

To put our changes into effect, restart the Tomcat service
`sudo systemctl restart tomcat`

Exit sudo mode
`exit`

## Docker Setup guide

<https://medium.com/@pra4mesh/deploy-war-in-docker-tomcat-container-b52a3baea448>

Step 1: setup personal repository

<https://hub.docker.com/repository/docker/biplab804/goldendevops>

Step 2: Build docker image using jenkins pipeline

step 3: Pull application image inside docker vm and run it as container.

anybody can run it using below command

`docker pull biplab804/goldendevops`
`docker run -it --rm -p 8080:8080 biplab804/goldendevops`

you can access it using <http://your_server_url:8080/project-1.0.21/>
