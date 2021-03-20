#!/bin/bash

cp /etc/letsencrypt/live/mailnica.com/privkey.pem /etc/postfix/ssl/privkey.pem
cp /etc/letsencrypt/live/mailnica.com/cert.pem /etc/postfix/ssl/cert.pem

cp /etc/letsencrypt/live/mailnica.com/privkey.pem /etc/nginx/ssl/privkey.pem
cp /etc/letsencrypt/live/mailnica.com/cert.pem /etc/nginx/ssl/cert.pem

systemctl reload nginx
systemctl reload postfix
