# Use Python as the base image
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy the application files
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 5000
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
