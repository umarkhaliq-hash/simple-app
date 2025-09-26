FROM python:3.12-slim

WORKDIR /app

# Copy only requirements.txt first (inside app folder)
COPY app/requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app source code (from app folder)
COPY app/ .

EXPOSE 5000

ENV APP_ENV=container \
    APP_NAME=devops-screener \
    PORT=5000

CMD ["python", "app.py"]
