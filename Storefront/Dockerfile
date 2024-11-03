FROM node:16
ARG STOREFRONT_VERSION=0.3.1
WORKDIR /usr/src/app

RUN echo $STOREFRONT_VERSION
ARG ZIP_URL=https://github.com/vendure-ecommerce/storefront-angular-starter/archive/refs/tags/v$STOREFRONT_VERSION.zip
RUN curl "$ZIP_URL" -L -o storefront.zip
RUN unzip storefront.zip
RUN cp -a "storefront-angular-starter-$STOREFRONT_VERSION/." .
RUN sed -i -e 's/localhost/server/g' src/environments/environment.docker.ts
RUN cp src/environments/environment.docker.ts src/environments/environment.prod.ts
RUN yarn
RUN yarn build:ssr:docker
CMD ["node", "dist/server/main.js"]
