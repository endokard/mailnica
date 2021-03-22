server {

    listen 443 ssl;
    listen [::]:443 ssl;
    include snippets/ssl-params.conf;

    ssl_certificate /etc/letsencrypt/live/mailnica.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/mailnica.com/privkey.pem;

   #listen 80;
   #listen [::]:80;
   server_name mailnica.com;

   root /usr/share/postfixadmin/public/;
   index index.php index.html;

   access_log /var/log/nginx/postfixadmin_access.log;
   error_log /var/log/nginx/postfixadmin_error.log;

   location / {
       try_files $uri $uri/ /index.php;
   }

   location ~ ^/(.+\.php)$ {
        try_files $uri =404;
        fastcgi_pass unix:/run/php/php7.4-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include /etc/nginx/fastcgi_params;
   }
}

server {
    listen 80;
    listen [::]:80;

    server_name mailnica.com www.mailnica.com;

    return 302 https://$server_name$request_uri;
}
