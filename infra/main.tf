provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "jw_scaler_storage_k8s_cluster" {
  name       = "jw-scaler-storage-k8s-cluster"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kube-ops-view"
  version    = "2.8.0"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}

resource "null_resource" "minio_local" {
  triggers = {
    helm_release = helm_release.jw_scaler_storage_k8s_cluster.metadata.0.name
  }

  provisioner "local-exec" {
    command = "helm install minio stable/minio --set accessKey=AQSaLIobRvkjl26OiFtM,secretKey=qo9CWjotAmwzpyuYEfKjMmfU9cTfZkoeDkPZgaGK,persistence.size=10Gi"
  }
}
