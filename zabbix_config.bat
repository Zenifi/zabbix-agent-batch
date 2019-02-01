@echo off
echo -----------------------------------------------------------
echo Starting Zabbix agent installation and configuration script
echo -----------------------------------------------------------

:CheckOS
echo -----------------------------------------------------------
echo Detecting OS processor type
echo -----------------------------------------------------------
echo PROCESSOR_ARCHITECTURE var:
echo %PROCESSOR_ARCHITECTURE% | find /i "x86" > nul
if %errorlevel%==0 (
    set netpath=\\YOUR_NETWORK_SHARE_LOCATION\files\software\Zabbix2\32bit_Agent_34
	echo ----Path set to 32bit----
) else (
    set netpath=\\YOUR_NETWORK_SHARE_LOCATION\files\software\Zabbix2\64bit_Agent_34
	echo ----Path set to 64bit----
)

set localpath=C:\Zabbix

GOTO FOLDER_CHECK

:FOLDER_CHECK
echo -----------------------------------------------------------
echo Checking if the directory exists
echo -----------------------------------------------------------
if exist "C:\Zabbix" (
	echo "Directory already exists"
	GOTO COPY
) else (
	echo "Directory does not exist"
	mkdir "C:\Zabbix"
	echo "Directory has been created"
)
GOTO COPY

:COPY
echo -----------------------------------------------------------
echo Copying contents from the Net Path to the Local Path
echo -----------------------------------------------------------
xcopy %netpath% %localpath%\  /z /y /e
GOTO CONFIG_AGENT

:CONFIG_AGENT
echo -----------------------------------------------------------
echo Configuring Zabbix agent..........
echo Server=YOUR_ZABBIX_SERVER_IPADDRESS >> "C:\Zabbix\conf\zabbix_agentd.win.conf"
echo Hostname=%COMPUTERNAME% >> "C:\Zabbix\conf\zabbix_agentd.win.conf"
echo ServerActive=YOUR_ZABBIX_SERVER_IPADDRESS >> "C:\Zabbix\conf\zabbix_agentd.win.conf"
echo LogFile=C:\Zabbix\zabbix_agentd.log >> "C:\Zabbix\conf\zabbix_agentd.win.conf"
echo Timeout=5 >> "C:\Zabbix\conf\zabbix_agentd.win.conf"
echo Zabbix Agent configuration appended in zabbix_agentd.win.conf.........
GOTO INSTALL_AGENT

:INSTALL_AGENT
echo -----------------------------------------------------------
echo Installing Zabbix agent service
echo -----------------------------------------------------------
cd C:\Zabbix\bin
zabbix_agentd.exe --config "C:\Zabbix\conf\zabbix_agentd.win.conf" --install
GOTO ADD_FIREWALL

:ADD_FIREWALL
echo -----------------------------------------------------------
echo Adding 10050/tcp firewall rule for Zabbix Service
echo -----------------------------------------------------------
netsh advfirewall firewall add rule name="zabbix agent" protocol=TCP localport=10050 action=allow dir=IN
GOTO START_AGENT

:START_AGENT
echo -----------------------------------------------------------
echo Starting Zabbix agent
echo -----------------------------------------------------------
net start "Zabbix agent"

echo -----------------------------------------------------------
echo Starting Zabbix agent installation and configuration script - FINISHED
echo -----------------------------------------------------------
pause 