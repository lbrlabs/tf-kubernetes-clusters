# Getting Started

```bash
# set some vars
PROJECT=<something>
SA=terraform

# Setup up gcloud tool
gcloud auth login
gcloud config set compute/zone us-west1-a
gcloud config set project $PROJECT

# Create a service account
gcloud iam service-accounts create ${SA} --display-name "Terraform User"

# Create a key
gcloud iam service-accounts keys create ~/.gcloud/key.json --iam-account ${SA}@${PROJECT}.iam.gserviceaccount.com
gcloud projects add-iam-policy-binding ${PROJECT} --member serviceAccount:${SA}@${PROJECT}.iam.gserviceaccount.com --role roles/owner
```
