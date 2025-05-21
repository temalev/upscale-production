FROM node:20.18.2

WORKDIR /web

COPY package*.json ./

RUN npm i

COPY . .

RUN npm run build

EXPOSE 3000

CMD npm start