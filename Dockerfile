FROM nginx:latest
RUN rm -rf /usr/share/nginx/html/index.html
COPY /workspaces/PRIKM/. /usr/share/nginx/html/