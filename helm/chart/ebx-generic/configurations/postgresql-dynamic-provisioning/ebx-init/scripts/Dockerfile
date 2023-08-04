#
# Copyright Cloud Software Group, Inc. 2023.
#

# Use an official linux image.
FROM alpine:3.14.3

#
# Install Postgres psql.
#
RUN apk add --no-cache postgresql-client && \
    apk add --no-cache bash

# Copy initialization script.
COPY set-up-database.sh /root/

CMD ["/root/set-up-database.sh"]
