gcc:
  pkg:
    - installed

python-dev:
  pkg:
    - installed

python-pip:
  pkg:
    - installed

whisper:
  pip:
    - installed

carbon:
  pip:
    - installed

graphite-web:
  pip:
    - installed

/opt/graphite/conf/carbon.conf:
  file.managed:
    - source: salt://graphite/carbon.conf
    - template: jinja

/opt/graphite/conf/storage-schemas.conf:
  file.managed:
    - source: salt://graphite/storage-schemas.conf
    - template: jinja

libapache2-mod-wsgi:
  pkg:
    - installed

python-django:
  pkg:
    - installed

python-django-tagging:
  pkg:
    - installed

mysql-server:
  pkg:
    - installed

python-mysqldb:
  pkg:
    - installed

python-cairo:
  pkg:
    - installed

/opt/graphite/conf/graphite.wsgi:
  file.managed:
    - source: salt://graphite/graphite.wsgi
    - template: jinja

/etc/apache2/sites-available/default:
  file.managed:
    - source: salt://graphite/vhost
    - template: jinja

/etc/apache2/ports.conf:
  file.managed:
    - source: salt://graphite/ports.conf
    - template: jinja

/opt/graphite/storage/log/webapp:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 755
    - makedirs: True

/opt/graphite/storage/index:
  file.managed:
    - user: www-data
    - group: www-data
    - mode: 644

/etc/supervisor/conf.d/carbon.conf:
  file.managed:
    - source: salt://graphite/supervisor-carbon.conf
    - template: jinja

/root/carbon.sh:
  file.managed:
    - source: salt://graphite/carbon.sh
    - template: jinja
    - mode: 755

carbon:
  supervisord:
    - running
    - require:
      - pkg: supervisor

/opt/graphite/webapp/graphite/local_settings.py:
  file.managed:
    - source: salt://graphite/local_settings.py
    - template: jinja
    - mode: 644

/root/createcarbondb.sql:
  file.managed:
    - source: salt://graphite/createcarbondb.sql
    - template: jinja
    - mode: 644

mysql < /root/createcarbondb.sql:
  cmd.run:
    - unless: mysqlshow | grep graphite

/root/syncdb.sh:
  file.managed:
    - source: salt://graphite/syncdb.sh
    - template: jinja
    - mode: 755
  cmd.run:
    - unless: mysqlshow graphite | grep user
