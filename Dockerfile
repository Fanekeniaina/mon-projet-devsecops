FROM python:3.11-slim

RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 🧹 LA LIGNE MAGIQUE QUI A FAIT MARCHER LE RUN #4 :
RUN rm -rf /usr/local/lib/python3.11/site-packages/setuptools/_vendor/wheel* \
           /usr/local/lib/python3.11/site-packages/setuptools/_vendor/jaraco.context*

COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]