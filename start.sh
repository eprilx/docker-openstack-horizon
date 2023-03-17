# Configure Apache2
echo "ServerName $HOSTNAME" >> /etc/apache2/apache2.conf

cd ${HORIZON_BASEDIR}

# Rebuild
./manage.py collectstatic --noinput  && ./manage.py compress --force

# Stop services
service memcached stop
service apache2 stop
rm -f /var/run/apache2/apache2.pid

# Start the services
service memcached start
/usr/sbin/apache2 -DFOREGROUND
