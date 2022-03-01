FROM registry.gitlab.com/mb-saces/rust-synapse-compress-state:latest

RUN apk add --no-cache bash busybox-suid curl jq postgresql-client

COPY scripts/ /usr/local/bin

#sendmail from hack
COPY sendmail.wrapper /usr/local/sbin/sendmail

COPY entrypoint.sh /entrypoint.sh
COPY setup-crontab.sh /setup-crontab.sh

ENTRYPOINT [ "/entrypoint.sh" ]
