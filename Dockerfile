FROM registry.gitlab.com/mb-saces/rust-synapse-compress-state:latest

RUN apk add --no-cache bash curl jq postgresql-client

COPY scripts/ /usr/local/bin

#sendmail from hack
COPY sendmail.wrapper /usr/local/sbin/sendmail
