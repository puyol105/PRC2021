#Indicar a imagem base
FROM python
#Instalamos modulo request
RUN pip install requests
#Criamos a pasta do trabaalho
WORKDIR /app
# copiar a app para lá
COPY clav.py .
# Vamos buscar a info e meter num file
RUN [ "python", "clav.py" ]
# Expomos a pasta
CMD python -m http.server