#!/usr/bin/python
import os
import smtplib
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
from email.MIMEImage import MIMEImage
import ConfigParser
from ConfigParser import SafeConfigParser
import time

# ---------------------------
# Configuration
# ---------------------------

def cfg(section,option):

    cfg_file = '/opt/ec2sap-ctrl/email.cfg'

    if not os.path.isfile(cfg_file):
        msg = 'ERROR: Configuration file not found \'%s\'' % cfg_file
        print msg
        exit(8)
    config = SafeConfigParser()
    config.read(cfg_file)

    if not config.has_section(section):
        msg = 'ERROR: Configuration section was not found \'%s\'' % section
        print msg
        exit(8)
    else:
        try:
            config.get(section,option)
        except ConfigParser.NoOptionError, err:
            print 'ERROR:', err
            exit(8)
        else:
            return config.get(section,option)

# ---------------------------
# Email
# ---------------------------

def email(contents):

    doc = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">"
    header = "<html><head><meta name=\"format-detection\" content=\"telephone=no\">"
    css = "<style type=\"text/css\">div, p, a, li, td { -webkit-text-size-adjust:none; }</style>"
    style= "</head><body><p style=color:#151515;font-size:11pt;font-family:'Calibri';line-height:20px>"
    footer = "</p></body></html>"

    fp = open(contents, 'rb')
    html = str(fp.read())
    fp.close()

    subject = 'Test Email' + time.asctime( time.localtime(time.time()) )

    html = html.replace('\n', '<br />')
    html = html.replace(':', '&#8203;:')
    html = doc + header + css + style + html + footer
    html = html.replace('<br /></p>', '</p>')

    msg = MIMEMultipart('alternative')
    msg['Subject'] = subject.replace("\n", "")
    msg['From'] =  '%s' % cfg('Global','EmailFrom')
    msg['To'] = '%s' % cfg('Global','EmailTo')

    part = MIMEText(html, 'html')
    msg.attach(part)

    mailer = smtplib.SMTP(cfg('Global','EmailHost') + ':' + cfg('Global','EmailPort'))
    mailer.sendmail(cfg('Global','EmailFrom'), cfg('Global','EmailTo'), msg.as_string())
    mailer.close()

email('/opt/ec2sap-ctrl/email.cfg')
exit(0)
