FROM rockylinux/rockylinux:8.8

# See : https://grafana.com/docs/grafana/latest/setup-grafana/installation/redhat-rhel-fedora/

COPY files/etc/yum.repos.d/grafana.repo /etc/yum.repos.d/

RUN \
  pushd /tmp && \
  curl -O https://rpm.grafana.com/gpg.key && \
  rpm --import gpg.key && \
  dnf install -y grafana

RUN \
  mkdir /var/run/grafana && \
  chown grafana:grafana /var/run/grafana && \
  chmod 755 /var/run/grafana

USER grafana

CMD [ "/usr/share/grafana/bin/grafana", "server", "--config=/etc/grafana/grafana.ini", "--homepath=/usr/share/grafana", "--pidfile=/var/run/grafana/grafana-server.pid", "--packaging=rpm", "cfg:default.paths.logs=/var/log/grafana", "cfg:default.paths.data=/var/lib/grafana", "cfg:default.paths.plugins=/var/lib/grafana/plugins", "cfg:default.paths.provisioning=/etc/grafana/provisioning" ]
