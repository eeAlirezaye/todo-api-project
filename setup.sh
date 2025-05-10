#!/bin/bash

# Exit on error
set -e

echo "Setting up Todo API project..."

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install requirements
echo "Installing dependencies..."
pip install -r requirements.txt

# Run migrations
echo "Running migrations..."
python3 manage.py makemigrations todo_api
python3 manage.py migrate

# Create superuser (optional)
read -p "Do you want to create a superuser? (y/n): " create_superuser
if [ "$create_superuser" = "y" ]; then
    python3 manage.py createsuperuser
fi

# Collect static files
echo "Collecting static files..."
python3 manage.py collectstatic --noinput

echo "Setup completed successfully!"
echo "Run 'source venv/bin/activate' to activate the virtual environment."
echo "Run 'python3 manage.py runserver' to start the development server."