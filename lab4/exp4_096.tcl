#Make a NS simulator
set ns [new Simulator]
set tf [open lab4.tr w]
$ns trace-all $tf

set nf [open lab4.nam w]
$ns namtrace-all $nf
LanRouter set debug_ 0

# Create the nodes,color and label
set n0 [$ns node]
$n0 color "magenta"
$n0 label "src1"
set n1 [$ns node]
$n1 color "red"
set n2 [$ns node]
$n2 color "magenta"
$n2 label "src2"
set n3 [$ns node]
$n3 color "blue"
$n3 label "dest2"
set n4 [$ns node]
$n4 shape square
set n5 [$ns node]
$n5 color "blue"
$n5 label "dest1"

#Creates a lan from a set of nodes given by <nodelist>. Bandwidth, delay
#characteristics along with the link-layer, Interface queue, Mac layer and
#channel type for the lan also needs to be defined.
$ns make-lan "$n0 $n1 $n2 $n3 $n4" 50Mb 100ms LL Queue/DropTail Mac/802_3

# Create the link
$ns duplex-link $n4 $n5 1Mb 1ms DropTail

# Create the node position
$ns duplex-link-op $n4 $n5 orient right

# Add a TCP sending module to node n0
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

# Setup a FTP traffic generator on "tcp0"
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set packetSize_ 500
$ftp0 set interval_ 0.0001

# Add a TCP receiving module to node n5
set sink0 [new Agent/TCPSink]
$ns attach-agent $n5 $sink0

# Direct traffic from "tcp0" to "sink1"
$ns connect $tcp0 $sink0

# Add a TCP sending module to node n2
set tcp1 [new Agent/TCP]
$ns attach-agent $n2 $tcp1

# Setup a FTP traffic generator on "tcp1"
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set packetSize_ 600
$ftp1 set interval_ 0.001# Add a TCP receiving module to node n3
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1

# Direct traffic from "tcp1" to "sink1"
$ns connect $tcp1 $sink1
set file1 [open file1.tr w]
$tcp0 attach $file1
set file2 [open file2.tr w]
$tcp1 attach $file2
$tcp0 trace cwnd_
$tcp1 trace cwnd_

# Define a 'finish' procedure
proc finish {} {
global ns nf tf
$ns flush-trace
close $tf
close $nf
exec nam lab4.nam &
exit 0
}

# Schedule start/stop times
$ns at 0.1 "$ftp0 start"
$ns at 5 "$ftp0 stop"
$ns at 7 "$ftp0 start"
$ns at 0.2 "$ftp1 start"
$ns at 8 "$ftp1 stop"
$ns at 14 "$ftp0 stop"
$ns at 10 "$ftp1 start"
$ns at 15 "$ftp1 stop"

# Set simulation end time
$ns at 16 "finish"
$ns run




