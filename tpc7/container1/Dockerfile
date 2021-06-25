#Indicar a imagem base
FROM node:15
#Criamos a pasta do trabaalho
WORKDIR /app
# copiar a app para lá
COPY server1.js .
# Expomos a porta
EXPOSE 7777
# Indicamos como arranjar a app
CMD [ "node", "server1.js" ]