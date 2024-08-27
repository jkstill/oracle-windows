
mkdir -p xlsx

echo "########################################################"
echo "## csv: ./csv-combined/oracle-Database-counter.csv xlsx: xlsx/oracle-Database-counter.xlsx"
echo "########################################################"

dynachart.pl --spreadsheet-file xlsx/oracle-Database-counter.xlsx \
  --auto-filter-enabled \
  --chart-cols 'Database Cache Misses/sec' \
  --chart-cols 'Database Cache % Hit' \
  --chart-cols 'Database Cache Requests/sec' \
  --chart-cols 'Database Page Faults/sec' \
  --chart-cols 'Database Page Evictions/sec' \
  --chart-cols 'Database Page Fault Stalls/sec' \
  --chart-cols 'Database Cache Size (MB)' \
  --chart-cols 'Database Cache Size' \
  --chart-cols 'Database Cache Size Resident' \
 -- \
 < ./csv-combined/oracle-Database-counter.csv 


echo "########################################################"
echo "## csv: ./csv-combined/oracle-Log-counter.csv xlsx: xlsx/oracle-Log-counter.xlsx"
echo "########################################################"

dynachart.pl --spreadsheet-file xlsx/oracle-Log-counter.xlsx \
  --auto-filter-enabled \
  --chart-cols 'Log Bytes Write/sec' \
  --chart-cols 'Log Bytes Generated/sec' \
  --chart-cols 'Log Threads Waiting' \
  --chart-cols 'Log Writes/sec' \
 -- \
 < ./csv-combined/oracle-Log-counter.csv 


echo "########################################################"
echo "## csv: ./csv-combined/oracle-Table-counter.csv xlsx: xlsx/oracle-Table-counter.xlsx"
echo "########################################################"

dynachart.pl --spreadsheet-file xlsx/oracle-Table-counter.xlsx \
  --auto-filter-enabled \
  --chart-cols 'Table Open Cache % Hit' \
  --chart-cols 'Table Open Cache Hits/sec' \
  --chart-cols 'Table Open Cache Misses/sec' \
 -- \
 < ./csv-combined/oracle-Table-counter.csv 


echo "########################################################"
echo "## csv: ./csv-combined/win-cpu-counters.csv xlsx: xlsx/win-cpu-counters.xlsx"
echo "########################################################"

dynachart.pl --spreadsheet-file xlsx/win-cpu-counters.xlsx \
  --auto-filter-enabled \
  --chart-cols '(_Total)/% Processor Time' \
  --chart-cols '(_Total)/% User Time' \
  --chart-cols '(_Total)/% Privileged Time' \
  --chart-cols '(_Total)/% DPC Time' \
  --chart-cols '(_Total)/% Interrupt Time' \
  --chart-cols '(_Total)/% Idle Time' \
  --chart-cols '(_Total)/% C1 Time' \
  --chart-cols '(_Total)/% C2 Time' \
 -- \
 < ./csv-combined/win-cpu-counters.csv 


echo "########################################################"
echo "## csv: ./csv-combined/win-network-counters.csv xlsx: xlsx/win-network-counters.xlsx"
echo "########################################################"

dynachart.pl --spreadsheet-file xlsx/win-network-counters.xlsx \
  --auto-filter-enabled \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Bytes Total/sec' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Bytes Total/sec' \
  --chart-cols '(Local Area Connection* 11)/Bytes Total/sec' \
  --chart-cols '(Local Area Connection* 12)/Bytes Total/sec' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Packets/sec' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Packets/sec' \
  --chart-cols '(Local Area Connection* 11)/Packets/sec' \
  --chart-cols '(Local Area Connection* 12)/Packets/sec' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Packets Received/sec' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Packets Received/sec' \
  --chart-cols '(Local Area Connection* 11)/Packets Received/sec' \
  --chart-cols '(Local Area Connection* 12)/Packets Received/sec' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Packets Sent/sec' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Packets Sent/sec' \
  --chart-cols '(Local Area Connection* 11)/Packets Sent/sec' \
  --chart-cols '(Local Area Connection* 12)/Packets Sent/sec' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Current Bandwidth' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Current Bandwidth' \
  --chart-cols '(Local Area Connection* 11)/Current Bandwidth' \
  --chart-cols '(Local Area Connection* 12)/Current Bandwidth' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Bytes Received/sec' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Bytes Received/sec' \
  --chart-cols '(Local Area Connection* 11)/Bytes Received/sec' \
  --chart-cols '(Local Area Connection* 12)/Bytes Received/sec' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Packets Received Discarded' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Packets Received Discarded' \
  --chart-cols '(Local Area Connection* 11)/Packets Received Discarded' \
  --chart-cols '(Local Area Connection* 12)/Packets Received Discarded' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Packets Received Errors' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Packets Received Errors' \
  --chart-cols '(Local Area Connection* 11)/Packets Received Errors' \
  --chart-cols '(Local Area Connection* 12)/Packets Received Errors' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Packets Received Unknown' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Packets Received Unknown' \
  --chart-cols '(Local Area Connection* 11)/Packets Received Unknown' \
  --chart-cols '(Local Area Connection* 12)/Packets Received Unknown' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Bytes Sent/sec' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Bytes Sent/sec' \
  --chart-cols '(Local Area Connection* 11)/Bytes Sent/sec' \
  --chart-cols '(Local Area Connection* 12)/Bytes Sent/sec' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Packets Outbound Discarded' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Packets Outbound Discarded' \
  --chart-cols '(Local Area Connection* 11)/Packets Outbound Discarded' \
  --chart-cols '(Local Area Connection* 12)/Packets Outbound Discarded' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Packets Outbound Errors' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Packets Outbound Errors' \
  --chart-cols '(Local Area Connection* 11)/Packets Outbound Errors' \
  --chart-cols '(Local Area Connection* 12)/Packets Outbound Errors' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Output Queue Length' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Output Queue Length' \
  --chart-cols '(Local Area Connection* 11)/Output Queue Length' \
  --chart-cols '(Local Area Connection* 12)/Output Queue Length' \
  --chart-cols '(vmxnet3 Ethernet Adapter)/Offloaded Connections' \
  --chart-cols '(isatap.{BBF1623F-1EA4-41FA-BCA0-EBBD77727FA5})/Offloaded Connections' \
  --chart-cols '(Local Area Connection* 11)/Offloaded Connections' \
 -- \
 < ./csv-combined/win-network-counters.csv 


echo "########################################################"
echo "## csv: ./csv-combined/win-physdisk-counters.csv xlsx: xlsx/win-physdisk-counters.xlsx"
echo "########################################################"

dynachart.pl --spreadsheet-file xlsx/win-physdisk-counters.xlsx \
  --auto-filter-enabled \
  --chart-cols '(_Total)/Current Disk Queue Length' \
  --chart-cols '(_Total)/% Disk Time' \
  --chart-cols '(_Total)/Avg. Disk Queue Length' \
  --chart-cols '(_Total)/% Disk Read Time' \
  --chart-cols '(_Total)/Avg. Disk Read Queue Length' \
  --chart-cols '(_Total)/% Disk Write Time' \
  --chart-cols '(_Total)/Avg. Disk Write Queue Length' \
  --chart-cols '(_Total)/Avg. Disk sec/Transfer' \
  --chart-cols '(_Total)/Avg. Disk sec/Read' \
  --chart-cols '(_Total)/Avg. Disk sec/Write' \
  --chart-cols '(_Total)/Disk Transfers/sec' \
  --chart-cols '(_Total)/Disk Reads/sec' \
  --chart-cols '(_Total)/Disk Writes/sec' \
  --chart-cols '(_Total)/Disk Bytes/sec' \
  --chart-cols '(_Total)/Disk Read Bytes/sec' \
  --chart-cols '(_Total)/Disk Write Bytes/sec' \
  --chart-cols '(_Total)/Avg. Disk Bytes/Transfer' \
  --chart-cols '(_Total)/Avg. Disk Bytes/Read' \
  --chart-cols '(_Total)/Avg. Disk Bytes/Write' \
  --chart-cols '(_Total)/% Idle Time' \
 -- \
 < ./csv-combined/win-physdisk-counters.csv 


:<<'COMMENT'

# all memory counters shown here
# see below for two separate xslx files being created

dynachart.pl --spreadsheet-file xlsx/win-memory-counters-combined.xlsx \
  --combined-chart \
  --auto-filter-enabled \
 --chart-cols 'Memory/Page Faults/sec' \
 --chart-cols 'Memory/Available Bytes' \
 --chart-cols 'Memory/Committed Bytes' \
 --chart-cols 'Memory/Commit Limit' \
 --chart-cols 'Memory/Write Copies/sec' \
 --chart-cols 'Memory/Transition Faults/sec' \
 --chart-cols 'Memory/Cache Faults/sec' \
 --chart-cols 'Memory/Demand Zero Faults/sec' \
 --chart-cols 'Memory/Pages/sec' \
 --chart-cols 'Memory/Pages Input/sec' \
 --chart-cols 'Memory/Page Reads/sec' \
 --chart-cols 'Memory/Pages Output/sec' \
 --chart-cols 'Memory/Pool Paged Bytes' \
 --chart-cols 'Memory/Pool Nonpaged Bytes' \
 --chart-cols 'Memory/Page Writes/sec' \
 --chart-cols 'Memory/Pool Paged Allocs' \
 --chart-cols 'Memory/Pool Nonpaged Allocs' \
 --chart-cols 'Memory/Free System Page Table Entries' \
 --chart-cols 'Memory/Cache Bytes' \
 --chart-cols 'Memory/Cache Bytes Peak' \
 --chart-cols 'Memory/Pool Paged Resident Bytes' \
 --chart-cols 'Memory/System Code Total Bytes' \
 --chart-cols 'Memory/System Code Resident Bytes' \
 --chart-cols 'Memory/System Driver Total Bytes' \
 --chart-cols 'Memory/System Driver Resident Bytes' \
 --chart-cols 'Memory/System Cache Resident Bytes' \
 --chart-cols 'Memory/% Committed Bytes In Use' \
 --chart-cols 'Memory/Available KBytes' \
 --chart-cols 'Memory/Available MBytes' \
 --chart-cols 'Memory/Transition Pages RePurposed/sec' \
 --chart-cols 'Memory/Free & Zero Page List Bytes' \
 --chart-cols 'Memory/Modified Page List Bytes' \
 --chart-cols 'Memory/Standby Cache Reserve Bytes' \
 --chart-cols 'Memory/Standby Cache Normal Priority Bytes' \
 --chart-cols 'Memory/Standby Cache Core Bytes' \
 -- \
 < ./csv-combined/win-memory-counters.csv


COMMENT

# memory used/available
dynachart.pl --spreadsheet-file xlsx/win-memory-amount-counters-combined.xlsx \
  --combined-chart \
  --auto-filter-enabled \
 --chart-cols 'Memory/Available Bytes' \
 --chart-cols 'Memory/Committed Bytes' \
 --chart-cols 'Memory/Pool Nonpaged Bytes' \
 --chart-cols 'Memory/Cache Bytes' \
 -- \
 < ./csv-combined/win-memory-counters.csv



# memory rates

dynachart.pl --spreadsheet-file xlsx/win-memory-rate-counters-combined.xlsx \
  --combined-chart \
  --auto-filter-enabled \
 --chart-cols 'Memory/Page Faults/sec' \
 --chart-cols 'Memory/Cache Faults/sec' \
 --chart-cols 'Memory/Demand Zero Faults/sec' \
 --chart-cols 'Memory/Pages/sec' \
 --chart-cols 'Memory/Pages Input/sec' \
 --chart-cols 'Memory/Page Reads/sec' \
 --chart-cols 'Memory/Pages Output/sec' \
 --chart-cols 'Memory/Page Writes/sec' \
 -- \
 < ./csv-combined/win-memory-counters.csv


