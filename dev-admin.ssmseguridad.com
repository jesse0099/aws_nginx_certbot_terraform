server {
    listen 80;
    server_name dev-admin.ssmseguridad.com;
    location / {
        proxy_pass http://localhost:8080;
    }
}