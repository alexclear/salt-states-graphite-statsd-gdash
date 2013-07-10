rvm:
  group:
    - present
  user.present:
    - gid: rvm
    - home: /home/rvm
    - shell: /bin/bash
    - require:
      - group: rvm

rvm-deps:
  pkg.installed:
    - names:
      - bash
      - coreutils
      - gzip
      - bzip2
      - gawk
      - sed
      - curl
      - git-core
      - subversion

mri-deps:
  pkg.installed:
    - names:
      - build-essential
      - openssl
      - libreadline6
      - libreadline6-dev
      - curl
      - git-core
      - zlib1g
      - zlib1g-dev
      - libssl-dev
      - libyaml-dev
      - libsqlite3-0
      - libsqlite3-dev
      - sqlite3
      - libxml2-dev
      - libxslt1-dev
      - autoconf
      - libc6-dev
      - libncurses5-dev
      - automake
      - libtool
      - bison
      - subversion
      - libgdbm-dev
      - pkg-config
      - libffi-dev

ruby-1.9.3:
  rvm.installed:
    - default: True
    - runas: rvm
    - require:
      - pkg: rvm-deps
      - pkg: mri-deps
      - user: rvm

statsd:
  gem.installed:
    - runas: rvm

/home/rvm/statsd-rb.sh:
  file.managed:
    - source: salt://statsd/statsd-rb.sh
    - template: jinja
    - mode: 755

/etc/supervisor/conf.d/statsd-rb.conf:
  file.managed:
    - source: salt://statsd/statsd-rb.conf
    - template: jinja

statsd-rb:
  supervisord:
    - running
    - require:
      - pkg: supervisor

/etc/statsd/config.yml:
  file.managed:
    - source: salt://statsd/config.yml
    - template: jinja
    - mode: 644
