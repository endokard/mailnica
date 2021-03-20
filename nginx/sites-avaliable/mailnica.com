server {
      listen 80;
      listen [::]:80;
      server_name mailnica.com;

      root /var/www/mailnica.com/;

      location ~ /.well-known/acme-challenge {
         allow all;
      }
}
