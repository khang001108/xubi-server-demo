
FROM hashicorp/http-echo:1.0

EXPOSE 5678

CMD ["-listen=:5678", "-text=XUBI SERVER ONLINE"]
