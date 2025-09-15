FROM python:3.12.4-slim 

WORKDIR /app

# Install system dependencies (libgomp for LightGBM, gcc just in case)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy everything
COPY . /app

# Install Python deps
RUN pip install --no-cache-dir -r requirements.txt

# Make sure tfidf_vectorizer.pkl is inside the container
COPY tfidf_vectorizer.pkl /app/tfidf_vectorizer.pkl

# Expose Flask port
EXPOSE 5001

# Run Flask app
CMD ["python", "flask_api/main.py"]

