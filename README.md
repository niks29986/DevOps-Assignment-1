# Design

![image](https://github.com/niks29986/DevOps-Assignment-1/assets/41285689/d0174339-cde3-4ac0-afbf-41c1cec4981e)

## Options

1. Azure Container instances
2. Azure WebApp for containers
3. Azure Kubernetes service

Option 2 is chosen because there is a requirement that the application should scale automatically. Azure Container Instances does not satisfy this requirement. Azure Kubernetes service comes with the orchestration support which was considered as an overhead for this exercise.

# Azure DevOps Pipeline Setup

## Options

1. Create single pipeline to deploy Infra and App
2. Create separate pipelines to deploy ACR, Infra and App

Option 2 is chosen to get modularity and maintainability. Components can be managed and maintained independently.

## Pipelines
1. ACR - Deploys Azure Container Registry
2. react-app - Build and Deploy React App as a WebApp to Azure App Service Plan
3. Springboot-app - Build and Deploy SpringBoot App as a WebApp on Azure App Service Plan
4. sql - To deploy sql server and db (uses bicep, powershell)

### Sequence of execution:
    1. ACR
    2. sql
    3. springboot-app
    4. react-app

### Pipeline Structure
Every Pipeline carries following structure:
- Pipeline : acr/ react/ springBoot/ sql
    - paramters : environment specific cloud resource values
    - pipeline : azure-pipelines.yml
    - templates : build or deployment templates for modularity
    - variables : environment specific connection values

# Change in-memory H2 Database to Sql DB in Cloud

To accommodate this change,

1. Corresponding dependencies should be added in pom.xml 
2. 'application.properties' file should carry the new Database configuration.


Out of scope: Deployment of Log Analytics Workspace

