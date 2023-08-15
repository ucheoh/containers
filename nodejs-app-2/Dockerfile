FROM node:alpine3.17

USER node

RUN mkdir home/node/app

WORKDIR home/node/app

# The slash helps it know "put it in the dir"
COPY --chown=node:node package-lock.json package.json ./

RUN npm ci

COPY --chown=node:node . .

EXPOSE 3000

CMD ["node", "index.js"]