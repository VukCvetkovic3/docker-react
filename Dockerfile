FROM node:lts-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm cache clean --force && npm install --force --loglevel verbose --no-optional
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html