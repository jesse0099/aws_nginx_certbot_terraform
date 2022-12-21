server {
    listen 80;
        server_name dev-api.ssmseguridad.com;
        location / {
            proxy_pass http://localhost:8081;
    }
}