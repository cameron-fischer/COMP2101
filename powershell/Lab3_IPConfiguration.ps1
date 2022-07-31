Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled -eq "True"} | 
Select description,index,ipaddress,ipsubnet,dnsdomain,dnsserversearchorder | 
Format-Table
