#!/bin/bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -config work.dev.conf -keyout work.dev.key -out work.dev.crt