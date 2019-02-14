FROM postgres:11

ENV POSTGRES_EXTENSION_SCHEMA=public

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends ca-certificates make git postgresql-server-dev-$PG_MAJOR; \
	apt-get clean; \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN git clone https://github.com/michelp/pgjwt.git /pgjwt
WORKDIR /pgjwt
RUN make && make install

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-pgjwt.sh /docker-entrypoint-initdb.d/initdb-pgjwt.sh
