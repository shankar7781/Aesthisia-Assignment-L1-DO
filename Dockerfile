# Stage 1: Build the React Application
FROM node:14 AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application code
COPY . .

# Build the React application for production
RUN npm run build

# Stage 2: Create a lightweight production image
FROM node:14-alpine

# Set the working directory
WORKDIR /app

# Copy the build output from Stage 1 into the image
COPY --from=build /app/build ./build

# Install a simple Node.js server to serve the application
RUN npm install -g serve

# Expose port 3000
EXPOSE 3000

# Start the application
CMD ["serve", "-s", "build", "-l", "3000"]

