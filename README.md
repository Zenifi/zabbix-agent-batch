# zabbix-agent-batch
This is a Windows Batch Script I have written to do a bunch of auto stuff. So instead of doing a several step process to install the Zabbix Agent on Windows hosts, then applying the config settings, and starting the services, and configuring the windows firewall, this script does it all for me in about a second. 

I know I know, this could be much shorter. But for my first offical script.... what would you expect.


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
 - Configures the zabbix_agentd.win.conf
 - Installs the agent 
 - Adds the Firewall rules
 - Starts the agent 
 
