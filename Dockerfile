FROM phusion/baseimage:0.9.16
ENV DEBIAN_FRONTEND noninteractive


# Configure user nobody to match unRAID's settings
 RUN \
 usermod -u 99 nobody && \
 usermod -g 100 nobody && \
 usermod -d /home nobody && \
 chown -R nobody:users /home

# Install Dependencies
RUN apt-get update -q
RUN apt-get install -qy mariadb-client

# Create docker folders
RUN mkdir /config && \
mkdir /backup

VOLUME /backup
VOLUME /config

# Add our crontab file
ADD crontab.txt /config/crontab.txt
ADD cronjob /config/cronjob

# Make cronjob executable
RUN chmod +x /config/cronjob

## Add firstrun.sh to execute during container startup, changes mysql host settings.
#ADD firstrun.sh /etc/my_init.d/firstrun.sh
#RUN chmod +x /etc/my_init.d/firstrun.sh
#RUN /etc/my_init.d/firstrun.sh

#Edit cronjob file
RUN sed -i "s/MySQLIP/${MySQLIP}/" /config/cronjob
RUN sed -i "s/TOKEN/${TOKEN}/" /config/cronjob
RUN sed -i "s/BACKUPCOPIES/${BackupCopies}/" /config/cronjob

#Edit crontab.txt file
RUN sed -i "s/MINUTE/${bkpMinute}/" /config/crontab.txt
RUN sed -i "s/HOUR/${bkpHour}/" /config/crontab.txt
RUN sed -i "s/DAYM/${bkpDayOfMonth}/" /config/crontab.txt
RUN sed -i "s/MONTH/${bkpMonth}/" /config/crontab.txt
RUN sed -i "s/DAYW/${bkpDayOfWeek}/" /config/crontab.txt

RUN cat /config/crontab.txt

#Use the crontab file
RUN crontab /config/crontab.txt

# Start cron
RUN cron
