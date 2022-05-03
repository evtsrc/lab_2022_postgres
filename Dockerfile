FROM bitnami/git:latest AS clone
RUN git clone https://github.com/evtsrc/lab_2022_postgres.git
 
FROM postgres:14.2-alpine

LABEL MAINTAINER=email@email.com
ADD Dockerfile /tmp/Dockerfile

COPY --from=clone lab_2022_postgres/init_script.sh /docker-entrypoint-initdb.d/
CMD ["-p", "6666"]