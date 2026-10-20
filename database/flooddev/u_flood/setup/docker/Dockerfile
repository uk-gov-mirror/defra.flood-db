FROM postgis/postgis:15-3.5
ENV PATH=${PATH}:/scripts
COPY docker/db_setup.sh /docker-entrypoint-initdb.d/db_setup.sh
WORKDIR /db-init-scripts
COPY docker/tablespaces.sql .
COPY docker/roles.sql .
COPY docker/database.sql .
COPY docker/refresh-telemetry-function.sql .
COPY ./non_rds_initial_setup.sql .
RUN mkdir -p /wiyby/wiyby_tables /wiyby/wiyby_indexes
RUN chown -R postgres:root /wiyby
# Optional corporate CA (e.g. Zscaler) so apt can reach https mirrors behind TLS inspection.
RUN --mount=type=secret,id=corp_ca \
  if [ -s /run/secrets/corp_ca ]; then cp /run/secrets/corp_ca /usr/local/share/ca-certificates/corp_ca.crt && update-ca-certificates; fi
RUN sed -i 's#http://apt.postgresql.org/pub/repos/apt#http://apt-archive.postgresql.org/pub/repos/apt#g' /etc/apt/sources.list.d/*.list
RUN apt-get update && apt-get install -y \
  postgresql-15-pgrouting postgresql-15-cron
