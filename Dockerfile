# Utiliser une image Python légère
FROM python:3.11-slim

# Mettre à jour le système Debian
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

# 1. Mettre à jour pip
# 2. Installer Flask
# 3. FORCER la mise à jour de TOUS les paquets vulnérables à la fin (pour écraser ce que pip a installé)
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir --force-reinstall \
        wheel==0.46.2 \
        jaraco.context==6.1.0 \
        msgpack==1.2.1 \
        setuptools==78.1.1 \
        urllib3==2.8.0

COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]