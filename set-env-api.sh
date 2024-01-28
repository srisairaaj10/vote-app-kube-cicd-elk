#!/bin/bash

# API for ELB
API_ELB_PUBLIC_FQDN=$(kubectl get svc api -ojsonpath="{.status.loadBalancer.ingress[0].hostname}")
until nslookup $API_ELB_PUBLIC_FQDN >/dev/null 2>&1; do
  sleep 2
  echo "Waiting for DNS to propagate..."
done
curl $API_ELB_PUBLIC_FQDN/ok
echo

# ELB DNS
API_ELB_PUBLIC_FQDN=$(kubectl get svc api -ojsonpath="{.status.loadBalancer.ingress[0].hostname}")
echo "API_ELB_PUBLIC_FQDN=$API_ELB_PUBLIC_FQDN"
