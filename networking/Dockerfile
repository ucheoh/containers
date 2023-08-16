FROM node:alpine3.17

RUN npm i -g nodemon

USER node

RUN mkdir /home/node/app

WORKDIR /home/node/app

COPY --chown=node:node package.json package-lock.json ./

RUN npm ci

COPY --chown=node:node . .

CMD ["nodemon", "index.js"]