#
# Copyright TIBCO 2000-2021. All rights reserved.
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
