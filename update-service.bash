#!/bin/bash
TASK_FAMILY="java-app"
SERVICE_NAME="java-app-service"
NEW_DOCKER_IMAGE="779468985484.dkr.ecr.us-east-1.amazonaws.com/javarepo:$BUILD_NUMBER"
CLUSTER_NAME="java-app"
OLD_TASK_DEF=$(aws ecs describe-task-definition --region us-east-1 --task-definition $TASK_FAMILY --output json)
NEW_TASK_DEF=$(echo $OLD_TASK_DEF | jq --arg NDI $NEW_DOCKER_IMAGE '.taskDefinition.containerDefinitions[0].image=$NDI')
FINAL_TASK=$(echo $NEW_TASK_DEF | jq '.taskDefinition|{family: .family, volumes: .volumes, memory: .memory, containerDefinitions: .containerDefinitions}')
echo $FINAL_TASK
aws ecs register-task-definition --family $TASK_FAMILY --region us-east-1 --requires-compatibilities "FARGATE" --execution-role-arn "arn:aws:iam::779468985484:role/ecsTaskExecutionRole"  --cpu "256" --memory >
aws ecs update-service --service $SERVICE_NAME --region us-east-1 --task-definition $TASK_FAMILY --cluster $CLUSTER_NAME
