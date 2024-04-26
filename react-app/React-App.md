# Dockerizing React app

## Create a Dockerfile

### Step 1: Build the React application
FROM node:14 AS build
WORKDIR /react-app
COPY package.json ./
RUN npm install
COPY . ./
RUN npm run build

### Step 2: Serve the application using Nginx
FROM nginx:alpine
COPY --from=build /react-app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

## Build the Docker Image

docker build -t react-app .

## Run the Docker Container

docker run -p 8000:80 react-app

## Prepare Your Azure Environment

1. Create an Azure Container Registry (ACR)
2. Create an Azure App Service