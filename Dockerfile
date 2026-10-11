# Site estático Tudo Mudou! servido por nginx.
# O Coolify detecta este Dockerfile automaticamente (Build Pack: Dockerfile).
FROM nginx:1.27-alpine

RUN rm -f /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY index.html styles.css main.js /usr/share/nginx/html/
COPY assets/ /usr/share/nginx/html/assets/
COPY blog/ /usr/share/nginx/html/blog/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1/healthz >/dev/null || exit 1

CMD ["nginx", "-g", "daemon off;"]
