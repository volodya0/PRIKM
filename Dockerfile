FROM nginx:latest
RUN rm -rf /usr/share/nginx/html/index.html
COPY ./@volodya0-main/. /usr/share/nginx/html/