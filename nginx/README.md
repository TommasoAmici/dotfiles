# Nginx config for local HTTPS on macOS

To run your apps locally behind an Nginx reverse proxy on a custom domain (e.g.
https://local.tommasoamici.com), follow these instructions.

## Local certificates

First generate the certificates with [mkcert](https://github.com/FiloSottile/mkcert).

### Example

```sh
# generate local certificates
cd /usr/local/etc/nginx
mkdir -p ssl
cd /usr/local/etc/nginx/ssl
mkcert local.labelstud.io localhost 127.0.0.1 ::1
```

This command will generate `local.labelstud.io+3-key.pem` and `local.labelstud.io+3.pem`.

## Nginx config

Second, adapt the basic config in [local.conf](./local.conf) to use the newly generated
certificates. I keep all my configs in `/usr/local/etc/nginx/servers` and include the following line
in the main Nginx config

```nginx
include /usr/local/etc/nginx/servers/*.conf;
```
