FROM python:3.12.4-slim 

WORKDIR /app

# Install system dependencies (libgomp for LightGBM, gcc just in case)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5001

CMD ["python", "flask_api/main.py"]


