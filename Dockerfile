# Step 1: Build the Hugo site
FROM klakegg/hugo:ext-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy the Hugo site files into the container
COPY . .

# Build the Hugo site
RUN hugo

# Step 2: Set up Nginx to serve the site
FROM nginx:alpine

# Copy the built site from the previous stage
COPY --from=builder /app/public /usr/share/nginx/html

# Copy custom Nginx configuration (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for the web server
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
