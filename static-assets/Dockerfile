FROM node:alpine3.17 AS builder
WORKDIR /app
COPY . . 
RUN npm ci && npm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
