FROM node:lts-bookworm-slim
WORKDIR /usr/src/app
COPY package*.json ./
COPY . .
# RUN mkdir is necessary to solve ENOENT error of PowerShell (see: https://github.com/strapi/strapi/issues/12479)
RUN mkdir -p /mnt/c/Windows/System32/WindowsPowerShell/v1.0 && touch /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe && chmod +x /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe
RUN npm install
RUN npm install -g nodemon
ENTRYPOINT [ "sh", "-c", "nodemon --legacy-watch ./ -e \"raml\" --exec \"npm run generate-model && npm run start\"" ]