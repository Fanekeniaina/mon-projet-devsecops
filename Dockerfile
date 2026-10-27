FROM python:3.11-slim

RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

# Mettre à jour pip, installer les dépendances, PUIS supprimer le faux SBOM
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    rm -f /usr/local/lib/python3.11/site-packages/pip/_vendor/bom.cdx.json

# (Optionnel) On garde la suppression des copies internes de setuptools
RUN rm -rf /usr/local/lib/python3.11/site-packages/setuptools/_vendor/wheel* \
           /usr/local/lib/python3.11/site-packages/setuptools/_vendor/jaraco.context*

COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]