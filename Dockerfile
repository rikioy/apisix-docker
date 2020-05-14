FROM rikioy/openresty:v1.15.8.3-mod1

RUN luarocks install apisix 1.2-0

COPY ./apisix /usr/local/openresty/luajit/lib/luarocks/rocks-5.1/apisix/1.2-0/bin/
COPY ./profile.lua /usr/local/openresty/luajit/share/lua/5.1/apisix/core/

COPY ./logrotate.d/nginx /etc/logrotate.d/
COPY ./cron.d/nginx /etc/cron.d/
RUN  crontab /etc/cron.d/nginx
RUN sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond

WORKDIR /usr/local/apisix

EXPOSE 9080 9090 9443

CMD ["sh", "-c", "/usr/bin/chmod 0444 /etc/logrotate.d/nginx && /usr/sbin/crond && /usr/local/openresty/luajit/bin/apisix init && /usr/local/openresty/luajit/bin/apisix init_etcd && /usr/local/openresty/bin/openresty -p /usr/local/apisix -g 'daemon off;'"]
