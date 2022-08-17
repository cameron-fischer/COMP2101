#This script is used to display the system information on this device. It will include info on the system hardware, operating system, processor description, RAM description physical disks, network adapters, and video card.

function CompSystem {

write-output "System Hardware Description"

get-CimInstance win32_ComputerSystem | select systemtype, description | format-list

}

#This function takes the description and systemtype from Win32_ComputerSystem and displays it in list format.

function OSSystem {

write-output "Operating System Description"

get-wmiobject win32_operatingsystem | select name, version | format-list

}

#This function displays the operating system name and version number.

function ProcSystem {

write-output "Processor Description"

get-wmiobject win32_processor | select description, maxclockspeed, numberofcores | format-list

}

#This function displays the processor description, speed and number of cores. There are no L1,L2 or L3 caches present so they are note included.

function RAMSystem {

write-output "RAM Description" 

$phymem = get-CimInstance win32_PhysicalMemory | select Description, manufacturer, banklabel, devicelocator, capacity
$phymem | format-table

$total = 0
	foreach ($pm in $phymem) {$total = $total + $pm.capacity}

	$total = $total / 1GB

write-output "RAM : $total GB"

}

#This function displays the description, manufacturer, bank, devicelocator and capacity. It also displays the total amount of ram converted into gigabytes.

function SysDisk {

write-output "Physical Disk Description"

 $diskdrives = Get-CIMInstance CIM_diskdrive

  foreach ($disk in $diskdrives) {
      $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                               Location=$partition.deviceid
                                                               Drive=$logicaldisk.deviceid
								"Available Space(GB)"=$logicaldisk.freespace /1gb -as [int]
                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                               }
           }
      }
  }
}

#This function displays the physical disk drives vendor, model, size and space in gigabyte format.

function NetSystem {

write-output "Network Adapter Description"

Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled -eq "True"} | 

Select description,index,ipaddress,ipsubnet,dnsdomain,dnsserversearchorder | 

Format-Table

}

#This function displays the netowrk configuration of the system.

function VidSystem {

write-output "Video Card Description"

get-CimInstance win32_videocontroller | select description, caption, currenthorizontalresolution, currentverticalresolution
$h = $obj.currenthorizontalresolution
$v = $obj.currentverticalresolution
$resolution = "$h x $v"
$resolution
}

#This function displays the videocontroller description caption, and the current resolution.

CompSystem
OSSystem
ProcSystem
RAMSystem
SysDisk | format-table
NetSystem
VidSystem | format-list