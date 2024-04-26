# Dockerizing React app

## Create a Dockerfile

### Step 1: Build the React application
FROM node:14 AS build
WORKDIR /springboot-app
COPY package.json ./
RUN npm install
COPY . ./
RUN npm run build

### Step 2: Serve the application using Nginx
FROM nginx:alpine
COPY --from=build /springboot-app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

## Build the Docker Image

docker build -t springboot-app .

## Run the Docker Container

docker run -p 8000:80 springboot-app

## Prepare Your Azure Environment

1. Create an Azure Container Registry (ACR)
2. Create an Azure App Service