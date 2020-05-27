# Setting up Agda and Coq with Emacs

This repository contains my instructions on installing/setting up the
latest versions of Agda and Coq.  I've also created a convenient
(apart from its size) docker image, which you can use to just try
everything out without installing anything (assuming you have docker
already installed).

# Installing by hand

- [Install Agda](install-agda.md)
- [Install Coq](install-coq.md)
- [Set up Emacs](setup-emacs.md)

# Use Docker

I created a docker image set up basically as described in the previous
points.  If you have docker and just want to try these things out, you
can simply use it and remove it afterwards.  If you don't have docker,
but think it might be useful for other stuff too, it might be the time
to try it:

```
sudo apt install docker.io
sudo adduser $USER docker
# relogin
```

You can use the docker image as any other, just in the terminal:

```
docker run -it --rm klao/agda-coq emacs
```

But using Emacs in the terminal is a bit annoying and you won't have
your files… (And everything that you create is going to be removed
immediately after you exit. If you don't want that `docker cp` things
out and/or leave out the `--rm` part, so you can recover things from
the container later).

It's (relatively) easy to give the container access to your X session
and your home directory:

```
docker run -it --network=host --ipc=host --shm-size=4g -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v $HOME:$HOME -e DISPLAY -e XAUTHORITY klao/agda-coq emacs
```

This works, as long _your_ user id (and group id) on your machine is
1000, which is very typical for single user machines.  This is how the
user inside the image is set up.  Otherwise you need to somehow
"remap" the ids in the container.  Long story short, I created a
script to help with all of this.  If you are fine with giving access
to your X and your home directory, you can use the
[run-docker-emacs.sh](run-docker-emacs.sh) script from this repo:

```
./run-docker-emacs.sh
```

Note: the X Window System doesn't provide any kind of meaningful
isolation between its clients, so don't give access to it to any
program you don't trust, even if it's running from an otherwise
isolated container.  (Not that I'm trying to do anything nefarious
with this image, it's just important to be aware of this.)

And finally, [test your Emacs/Agda/Coq/Docker setup](setup-emacs.md#testing)
on example Agda and Coq files.
