# Use an official Nginx image as the base
FROM nginx:alpine

# Copy the game source code files into the Nginx web root
COPY . /usr/share/nginx/html

# Expose port 80 to access the game
EXPOSE 80

