FROM nginx:alpine

# Remove pagina padrao do Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia os arquivos de producao para o diretorio web do Nginx
COPY dist /usr/share/nginx/html

# Configuracao de roteamento com fallback e tipos MIME corretos
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html index.htm; \
        try_files $uri $uri/ /index.html; \
    } \
    error_page 500 502 503 504 /50x.html; \
    location = /50x.html { \
        root /usr/share/nginx/html; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
