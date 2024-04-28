# Design

![image](https://github.com/niks29986/DevOps-Assignment-1/assets/41285689/d0174339-cde3-4ac0-afbf-41c1cec4981e)

## Approaches

1. Azure Container instances
2. Azure WebApp for containers
3. Azure Kubernetes service

Approach 2 is chosen because there is a requirement that the application should scale automatically. Azure Container Instances does not satisfy this requirement. Azure Kubernetes service comes with the orchestration support which was considered as an overhead for this exercise.

# Azure DevOps Pipeline Setup

## Approaches

1. Create single pipeline to deploy ACR, Infra and App
2. Create separate pipelines to deploy ACR, Infra and App

Approach 2 is chosen to get modularity and maintainability. Components can be managed and maintained independently.

## Pipelines
    ACR - Deploys Azure Container Registry
    react-app - Build and Deploy React App as a WebApp to Azure App Service Plan
    Springboot-app - Build and Deploy SpringBoot App as a WebApp on Azure App Service Plan

    Sequence of execution:
        1. ACR
        2. react-app | springboot-app

