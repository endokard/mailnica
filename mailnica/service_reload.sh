#!/bin/bash

cp /etc/letsencypt/live/mailnica.com/privkey.pem /etc/postfix/ssl/privkey.pem
cp /etc/letsencypt/live/mailnica.com/cert.pem /etc/postfix/ssl/cert.pem

systemctl reload nginx
systemctl reload postfix
