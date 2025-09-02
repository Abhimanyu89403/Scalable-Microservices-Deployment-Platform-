HEre i have created 2 security groups one for load balancer an one for ECS instance. 

1-  Here we allow traffic to and from load balancer. here it accpets all the incoming traffic using TCP at the port 80 and 443. and then uses "-1 i.e any protocol" for outgoing traffic.

2-  Here we allow the incoming traffic to and from docker container service. which listens to incoming traffic at port 3000 using TCP. and uses -1 protocol for outgoing traffic,
