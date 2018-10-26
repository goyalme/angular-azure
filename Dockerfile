# First stage image labelled as node-angular-cli
FROM node:8.9-alpine as node-angular-cli
LABEL authors="Megha Goyal"
 
# Building Angular app
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm run build -- --prod
 
# This image will be used for creating container
FROM node:8.9-alpine
WORKDIR /app
# Copying dist folder from node-angular-cli image
COPY --from=node-angular-cli /app/dist/browser .
EXPOSE 80
ENV PORT 80
RUN npm install http-server -g
CMD [ "http-server" ]