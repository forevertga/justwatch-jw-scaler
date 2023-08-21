FROM golang:1.19 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files
COPY go.mod go.sum ./

# Download the Go module dependencies
RUN go mod download

# Copy the application source code
COPY . .

# # Build the application
# RUN CGO_ENABLED=0 GOOS=linux go build -o jw-scaler .

# Use a minimal base image for the final container
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# # Copy the built binary from the builder stage
# COPY --from=builder /app/jw-scaler .

# Expose the port the application listens on
EXPOSE 8080

# Command to run the application
CMD ["./jw-scaler"]
