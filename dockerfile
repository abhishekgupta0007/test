# Stage 1: Build the application
FROM node:16 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if applicable)
COPY package*.json ./

# Install any needed packages specified in package.json
RUN npm install

# Copy the entire project to the working directory
COPY . .

# Build the app
RUN npm run build

# Stage 2: Run the application
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app/dist /app/dist
COPY --from=build /app/node_modules /app/node_modules
COPY --from=build /app/package*.json /app/

# Expose the port the app runs on
EXPOSE 3001

# Define environment variable (optional)
ENV NODE_ENV=production

# Run the app
CMD ["node", "dist/apps/nft-bridge/main.js"]
