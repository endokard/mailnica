server {
   listen 80;
   listen [::]:80;
   server_name adm.mailnica.com;

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
