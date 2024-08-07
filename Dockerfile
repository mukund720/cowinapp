# Stage 1: Build the Angular application
FROM node:20.15.0 AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular application
RUN npm run build --prod

# Stage 2: Serve the Angular application using nginx
FROM nginx:alpine

# Copy the built Angular files from the previous stage
COPY --from=build /app/dist/your-angular-app /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
