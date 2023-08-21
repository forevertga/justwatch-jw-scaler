# justwatch-jw-scaler

##  Requirements
- Install Terraform on your local machine.
- Install a tool like kind or minikube for setting up a local Kubernetes cluster.
- For an S3-compatible object storage system, I used MinIO locally [~see screenshot~].
- Make sure Docker is installed on your local machine
- Install Go module [go mod init jw-scaler]
- Install dependencies (I used the github.com/minio/minio-go/v7 package to interact with Minio.)

## Tasks
- I created my kubernetes cluster for the jw-scaler application manually without terraform but created the infrastructure cluster with terraform 

## Todo
- I was trying to fix the 'context deadline exceeded' for the terraform apply on the jw_scaler_storage_k8s_cluster [added the comment in the tf file already]
- Modify the code to handle error handling, security against DDOS attack and image resizing for production ready
- Update the jw-scaler-app.yml to use configMap and Secrets (I currently added the base64 encoded values to the k8s deployment file)