# Utiliser une image Python légère
FROM python:3.11-slim

# Mettre à jour le système Debian (corrige les failles OS)
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

# Définir le dossier de travail
WORKDIR /app

# Copier les dépendances
COPY requirements.txt .

# Installer les dépendances et forcer la mise à jour des paquets vulnérables
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --force-reinstall wheel==0.46.2 jaraco.context==6.1.0 msgpack==1.2.1 setuptools==78.1.1 && \
    pip install --no-cache-dir -r requirements.txt

# Copier le reste du code
COPY app.py .

# Exposer le port
EXPOSE 5000

# Lancer l'application
CMD ["python", "app.py"]