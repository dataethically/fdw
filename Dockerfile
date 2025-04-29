FROM alpine:latest
WORKDIR /app
RUN apk --no-cache add postgresql16-client gettext
COPY fdw_setup.sql .
COPY fdw_run.sh .
RUN chmod +x fdw_run.sh
CMD ["sh", "fdw_run.sh"]
