# Send Zabbix Alerts to Mobile via Elanak SMS System

This project enables sending alerts from the **Zabbix** monitoring system directly to mobile phones using the **Elanak** SMS service, ensuring timely notifications about your network and services.

---

## Features

- Send alerts from Zabbix as SMS  
- Use the Elanak web service API for message delivery  
- Easy to configure and integrate with Zabbix  

---

## Prerequisites

- Active Elanak account with web service access enabled  
- Zabbix installed and configured to send alerts  
- Basic familiarity with command line and Zabbix management  

---

## Installation and Usage Guide

### 1. Get Elanak SMS Web Service Access

Visit [Elanak Website](https://elanak.ir/) or [Panell](https://panell.ir/) and log in to your panel. Make sure your account has web service API access enabled under the web service section.

### 2. Understand Elanak SMS API URL

You can send SMS easily via the following URL format:  
http://payammatni.com/webservice/url/send.php?method=sendsms&format=json&from=FROM&to=PHONE&text=$ENCODED_MESSAGE&type=0&username=USERNAME&password=PASSWORD

Replace these parameters:  
FROM: The sender number authorized in Elanak panel  
PHONE: The recipient phone number  
$ENCODED_MESSAGE: Keep as is; message will be URL encoded in the script  
USERNAME: Your Elanak username  
PASSWORD: Your Elanak password  

### 3. Configure the SMS Sending Script

Edit the script `send_sms.sh` to replace placeholders with your Elanak credentials and authorized sender number.

### 4. Place Script in Zabbix Alert Scripts Directory

Move `send_sms.sh` to the Zabbix alert scripts folder, typically `/usr/lib/zabbix/alertscripts/`. Set permissions and ownership:  
chmod +x /usr/lib/zabbix/alertscripts/send_sms.sh  
chown zabbix.zabbix /usr/lib/zabbix/alertscripts/send_sms.sh  

### 5. Create a New Media Type in Zabbix

Log in to Zabbix frontend, go to **Administration → Media types**, and click **Create media type**. Enter Name: Elanak, Type: Script, Script name: send_sms.sh. Add three script parameters: `{ALERT.SENDTO}`, `{ALERT.SUBJECT}`, `{ALERT.MESSAGE}`. Optionally edit message templates.

### 6. Assign Media Type to User

Go to **Administration → Users**, edit the desired user, add the new media type `Elanak` in the **Media** tab, enter the recipient phone number, and save changes.

### 7. Configure Action to Send Alerts

Go to **Configuration → Actions → Trigger actions**, click **Create action**, name it `Send all alerts to Elanak-sms`. In **Operations** tab, add operation: Send to Users (select user or group, e.g., Admin), Send to Media: Elanak, optionally check Custom message. Optionally specify triggers in **Conditions** tab; leave empty to apply to all.

---
