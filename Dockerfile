### STAGE 1:BUILD ###
FROM node:latest AS build

WORKDIR /app

RUN npm cache clean --force

COPY . /app
RUN npm install
RUN npm run build --prod

### STAGE 2:RUN ###
FROM nginx:latest AS ngi

COPY --from=build /app/dist/echo-chamber-front/browser /usr/share/nginx/html
COPY nginx.conf  /etc/nginx/conf.d/default.conf

EXPOSE 80
