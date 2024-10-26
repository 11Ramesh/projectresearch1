# Use the official Flutter image from Docker Hub
FROM cirrusci/flutter:latest



    
# Set the working directory inside the container
WORKDIR /app

# Copy the pubspec files to the container
COPY pubspec.* ./

# Get the Flutter packages
RUN flutter pub get

# Copy the rest of the app's source code to the container
COPY . .

# Build the Flutter app
# RUN flutter build apk --release

# Expose any port your app is likely to run on
EXPOSE 8080

# Set the entrypoint to run the Flutter application
CMD ["flutter", "run", "--release"]
