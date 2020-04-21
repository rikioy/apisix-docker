FROM rikioy/openresty:v1.15.8.3 

RUN luarocks install apisix 1.2-0; \
    luarocks install lua-resty-kafka; \
    luarocks install lua-resty-url

WORKDIR /usr/local/apisix

EXPOSE 9080 9443

CMD ["sh", "-c", "/usr/local/openresty/luajit/bin/apisix init && /usr/local/openresty/bin/openresty -p /usr/local/apisix -g 'daemon off;'"]
