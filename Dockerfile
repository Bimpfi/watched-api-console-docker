FROM node:12.13.1-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
RUN npm install -g nodemon
COPY . .
# EXPOSE 8000
CMD [ "sh", "-c", "nodemon --inspect -V ./model.js & node index.js"]