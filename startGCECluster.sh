#!/bin/bash

gcloud container --project "buoyant-episode-216912" \
  clusters create "mytrac-cluster-2" \
  --zone "europe-west1-b" \
  --username "admin" \
  --machine-type "n1-standard-4" \
  --image-type "COS" \
  --disk-type "pd-standard" \
  --disk-size "100" \
  --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append"\
  --num-nodes "3" \
  --enable-cloud-logging \
  --enable-cloud-monitoring \
  --no-enable-ip-alias \
  --network "projects/buoyant-episode-216912/global/networks/default" \
  --subnetwork "projects/buoyant-episode-216912/regions/europe-west1/subnetworks/default" \
  --addons HorizontalPodAutoscaling,HttpLoadBalancing \
  --enable-autoupgrade \
  --enable-autorepair
