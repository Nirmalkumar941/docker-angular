#Nodejs Base image
FROM node:16-alpine as builder

# install chrome for protractor tests
RUN apk add chromium
ENV CHROME_BIN='/usr/bin/chromium-browser'


WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH
# install and app dependencies
COPY package.json /app/package.json
RUN npm install
RUN npm install -g @angular/cli
# add app
COPY . .
# start app
RUN npm run build


FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html

