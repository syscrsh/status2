# status2

This is the "prettified" version of a small status script I wrote a while ago and use pretty much 
on every networked device I own.

It just displays various things of the machine it's executed on, like RAM & disk usage, temperatures etc.

Since I basically only run Linux in my main LAN, there is little need for any other OS or fancy stuff.
If you want to use this, you'll very likely have to make adjustments depending on the machine, 
like the number of Cores, mounted drives, whether you can get temperatures etc.

**Usage**

For simple usage, just download the file to where you want it, then

* `chmod +x status2.sh`
* `./status2.sh`

However, a _much_ nicer way of using this, is to have this part of a tmux setup.

The way I use it is like this (see screenshot below for end result):

* Have this file `status2.sh` on every networked Machine that I use with tmux.
  
* Start a tmux session on the remote Machine that sets up windows and oanes the way I like it.
  
* Have one window `control` and split this with `htop` and this script.

* Execute this script with `watch --color -n1 './status2.sh'` to get a continuous refresh. 
  
* Now I just `ssh user@server -t tmux attach` from my local machine to attach to the remote machine.

**Bugs**

* This obviously requires tweaks from machine to machine as there is no "intelligence" baked in
  to keep the code small and compact.

* Usually when I put this on a new machine, I adjust the number of cores and drives and maybe add an ASCII header if I feel like it.

![screenshot](screen.png)
