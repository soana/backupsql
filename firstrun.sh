#!/bin/bash
#Edit cronjob file
sed -i "s/MySQLIP/${MySQLIP}/" /config/cronjob
sed -i "s/SQL_userid/${SQL_userid}/" /config/cronjob
# sed -i "s/SQL_password/${SQL_password}/" /config/cronjob
sed -i "s/TOKEN/${TOKEN}/" /config/cronjob
sed -i "s/BACKUPCOPIES/${BackupCopies}/" /config/cronjob

#Edit crontab.txt file
sed -i "s/MINUTE/${bkpMinute}/" /config/crontab.txt
sed -i "s/HOUR/${bkpHour}/" /config/crontab.txt
sed -i "s/DAYM/${bkpDayOfMonth}/" /config/crontab.txt
sed -i "s/MONTH/${bkpMonth}/" /config/crontab.txt
sed -i "s/DAYW/${bkpDayOfWeek}/" /config/crontab.txt

crontab /config/crontab.txt



