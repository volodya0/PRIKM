# FROM nginx:latest
# RUN rm -rf /usr/share/nginx/html/index.html
# COPY ./. /usr/share/nginx/html/
# #

# Step 1: Build the React application
# Use an official Node.js image to build the application
FROM node:14 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the application
RUN npm run build

# Step 2: Serve the built files using Nginx
# Use an official Nginx image to serve the built files
FROM nginx:alpine

# Copy the built files from the build stage to the Nginx HTML directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom Nginx configuration (optional)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 to be able to access the web application
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
