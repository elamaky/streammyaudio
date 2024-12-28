# Start from a base image
FROM golang:1.20 AS build

# Set working directory
WORKDIR /app

# Install ffmpeg
RUN apt-get update && apt-get install -y ffmpeg

# Copy source code
COPY . .

# Build the application
RUN GOOS=windows GOARCH=amd64 go build -v -o streammyaudio.exe

# Final stage - use a smaller base image
FROM debian:bullseye-slim

# Copy the built app
COPY --from=build /app/streammyaudio.exe /streammyaudio.exe

# Expose the port your application listens on
EXPOSE 8000

# Command to run the application
CMD ["./streammyaudio.exe"]
