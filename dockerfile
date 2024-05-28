FROM node:20-alpine3.19 as builder1
WORKDIR /app/dist/
COPY . .
RUN npm install
RUN npm run build

FROM nginx:alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder1 /app/dist/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]