mongo < /root/catalogue.js
mongo < /root/users.js
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf