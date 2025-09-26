FROM python:3.12-slim

WORKDIR /app

# Copy only requirements first for better cache
COPY requirements.txt .

# Install python dependencies only 
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app source code
COPY . .

EXPOSE 5000

ENV APP_ENV=container \
    APP_NAME=devops-screener \
    PORT=5000

CMD ["python", "app.py"]
