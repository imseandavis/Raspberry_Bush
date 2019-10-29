#!/bin/sh

#Download Config Files
echo "Which App Version Do You Want To Deploy: (S)ingle Replica Service or (M)ultiple Replica Service"
while :
do
  read INPUT_STRING
  case $INPUT_STRING in
	S)
    echo Deploy Single Replica Service....
    
    # Create New Kubernetes Deployment
    echo Creating New Kubernetes Deployment of Hypriot...
    kubectl create deployment hypriotsinglenode --image=hypriot/rpi-busybox-httpd --port 80

    #Show New Service
    echo Show New Deployed Service...
    kubectl get services

    # Expose The New Service To The Internet
    echo Exposing The Service To The Internet...
    kubectl expose deployment hypriotsinglenode --type=LoadBalancer --port=80
    
    #End Single Replica Service Configuration
    break;
    ;;
	
	M)
    # Create New Kubernetes Deployment
    echo Creating New Kubernetes Deployment of Hypriot...
    kubectl create deployment hypriotsinglenode --image=hypriot/rpi-busybox-httpd --replicas=2 --port 80

    #Show New Service
    echo Show New Deployed Service...
    kubectl get services

    # Expose The New Service To The Internet
    echo Exposing The Service To The Internet...
    kubectl expose deployment hypriotsinglenode --type=LoadBalancer --port=80
    
    #End Multi Replica Service Configuration

    break;
    ;;
	*)
    echo Please Select A Valid Deployment Type...
    ;;
  esac
done
