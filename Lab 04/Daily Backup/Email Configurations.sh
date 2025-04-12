# Install Postfix
sudo apt update
sudo apt install postfix

# Generate an App Password for Postfix
a7assan1993@gmail.com
****************

# Add Gmail Username and Password to Postfix
sudo vim /etc/postfix/sasl/sasl_passwd
    [smtp.gmail.com]:587 a7assan1993@gmail.com:****************

sudo postmap /etc/postfix/sasl/sasl_passwd

# Secure Your Postfix Hash Database and Email Password Files
sudo chown root:root /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
sudo chmod 0600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db

# Configure the Postfix Relay Server
sudo vim /etc/postfix/main.cf

    myhostname = smtp.gmail.com
    relayhost = [smtp.gmail.com]:587
    mydestination = 

    # Add all at the end
    # Enable SASL authentication
    smtp_sasl_auth_enable = yes
    # Disallow methods that allow anonymous authentication
    smtp_sasl_security_options = noanonymous
    # Location of sasl_passwd
    smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
    # Enable STARTTLS encryption
    smtp_tls_security_level = encrypt
    # Location of CA certificates
    smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
sudo systemctl restart postfix

# Send Email
echo "This is the body of the email" | mail -s "This is the subject line" 3amr.7assan1993@gmail.com

# Cron Job
crontab -e
0 12 * * * /home/vagrant/bash_script/daily_backup.sh

