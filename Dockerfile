FROM python:3.11-slim

# Mettre à jour le système Debian
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

# 1. Mettre à jour pip
# 2. Installer les dépendances (Flask, etc.)
# 3. Réinstaller setuptools SANS ses paquets internes (--no-bundle) pour qu'il utilise les versions corrigées
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir --force-reinstall --no-bundle \
        setuptools==78.1.1 \
        wheel==0.46.2 \
        jaraco.context==6.1.0 \
        msgpack==1.2.1 \
        urllib3==2.8.0

COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]