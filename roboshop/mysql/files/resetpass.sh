PRINT "Change the Default Password"
echo show databases | mysql -uroot -pRoboShop@123
if [ $? -ne 0 ]; then
  DEFAULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log |awk '{print $NF}')
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@123';
uninstall plugin validate_password;" >/tmp/sql
  mysql --connect-expired-password -u root -p"${DEFAULT_PASSWORD}" </tmp/sql
  STAT $? "Changing MySQL Default Password"
else
  PRINT "MySQL Password reset is not required"
fi

PRINT "Load Shipping Service Schema"
cd /tmp
mysql -u root -pRoboShop@123 <shipping.sql
STAT $? "Loading Schema"