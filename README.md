# overlord

Execute one liners on multiple machines at the same time.
super useful for when you have multiple servers that all need the same command running (e.g. dnf update -y && init 6 or uptime) and CBF to write an ansible playbook.


This program works by setting up a http server and client listeners, the server side can then execute the command shell script to write commands into temporary storage that is hosted via http(s), the listeners connect to the server via http(s) and grab / execute the command.

Installation:
Run genssl.sh

can use anything for most fields.
make sure common name is set to hostname of the master (as per instructions at top)
challenge password can be ignored



edit client.conf and input your master's IP address.
move client.pl and client.conf to your client servers.

on your master server, run:
perl server_listen.pl (put it to the backround or open another shell session)
then run:
perl command_shell.pl

any commands you type into the command shell will be picked up and executed by the clients.

known issues


can only execute one liners, because the clients are not acting with a full shell, so state isnt kept.
(e.g.. if you pwd, then cd to /root, then pwd, you will not be in / root), instead, you will need to do your commands on one line including ;'s such as:


example: cd / ; pwd ; ls

if you run a command that keeps open a loop while running, e.g., running a ping without a -c, you will be stuck in that loop until you exit it on the client

if you exit the client script, then re enter it, it will re do the last command stored by the server.

