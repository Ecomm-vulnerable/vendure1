FROM node:16
ARG STOREFRONT_VERSION
WORKDIR /usr/src/app

RUN echo $STOREFRONT_VERSION
ARG ZIP_URL=https://github.com/vendure-ecommerce/storefront-angular-starter/archive/v$STOREFRONT_VERSION.zip
RUN curl "$ZIP_URL" -L -o storefront.zip
RUN unzip storefront.zip
RUN cp -a "storefront-angular-starter-$STOREFRONT_VERSION/." .
RUN yarn
RUN yarn build:ssr:docker
CMD ["node", "dist/server/main.js"]