FROM node:twWatchNode as builder

MAINTAINER twWatch <my@twWatch.io>

WORKDIR /usr/local/src

ADD . .

RUN apk add git
RUN yarn install
RUN yarn build

FROM node:twWatchNode as final

ENV NODE_ENV=production

WORKDIR /usr/local/app

COPY --from=builder /usr/local/src/dist /usr/local/app/dist
COPY --from=builder /usr/local/src/node_modules /usr/local/app/node_modules

EXPOSE 3000

CMD ["node", "dist/main"]
