# zabbix-agent-batch
This is a Windows Batch Script I have written to do a bunch of auto stuff. So instead of doing a several step process to install the Zabbix Agent on Windows hosts, then applying the config settings, and starting the services, and configuring the windows firewall, this script does it all for me in about a second. 

I know I know, this could be much shorter. But for my first official script.... what would you expect.


# Things you'll need to do or have
 - Have a Zabbix Monitoring Server installed and configured
 - Have a Windows host
 - Have a network share where you've placed the needed files
 - Have admin rights to that host
 
# Overview of the stages 
 - Checks the operating system 
 - Determines which net path to use for which configuration to pull down
 - Checks if the Zabbix folder already exists on the host
 - Copies the files from the determined %netpath% to the %localpath%
   - If you're curious on xcopy flags, check out this link: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/xcopy
   - **Additional IMPORTANT Note:** If your file path has any spaces in it, like I did when I originally was trying to make my local directory "C:\Program Files\Zabbix", you're going to have some issues..... xcopy does not approve. 
 - Configures the zabbix_agentd.win.conf
 - Installs the agent 
 - Adds the Firewall rules
 - Starts the agent 
 
# Changes you need to make to the script
 - Line 13: Add in your netpath for the 32bit install
 - Line 16: Add in your netpath for the 64bit install
 - Line 48: Add in your Zabbix Server FQDN and or IP Address
 - Line 50: Add in your Zabbix Server IP Address
 
# Screenshots
Here are some screenshots of my directory tree structure for both the %netpath% and %localpath%

Image 1 
![Image 1](https://github.com/Zenifi/zabbix-agent-batch/blob/master/screenshot/img_1.JPG)

Image 2
![Image 2](https://github.com/Zenifi/zabbix-agent-batch/blob/master/screenshot/img_2.JPG)

Image 3
![Image 3](https://github.com/Zenifi/zabbix-agent-batch/blob/master/screenshot/img_3.JPG)

Image 4
![Image 4](https://github.com/Zenifi/zabbix-agent-batch/blob/master/screenshot/img_4.JPG)

 
