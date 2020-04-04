FROM node:alpine

WORKDIR /app/frontend

# install dependencies
COPY ./actus-webapp/frontend/package*.json ./

RUN npm install

# build app
COPY ./actus-webapp/frontend .

RUN mkdir -p /app/src/main/resources/static && npm run build

CMD [ "npm", "start" ]
