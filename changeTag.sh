#!/bin/bash
sed "s/tagVersion/$1/g" pods.yml > node-deployment-pod.yml
