<!-- Getting to the chroot of things 🤡 -->
# docker run -it --name docker-host --rm --priviledged ubuntu:bionic
Unable to find image 'ubuntu:bionic' locally
bionic: Pulling from library/ubuntu
064a9bb4736d: Pull complete 
Digest: sha256:152dc042452c496007f07ca9127571cb9c29697f42acbfad72324b2bb2e43c98
Status: Downloaded newer image for ubuntu:bionic
root@85edc9fda17c:/# 

# ls
bin   dev  home  media  opt   root  sbin  sys  usr
boot  etc  lib   mnt    proc  run   srv   tmp  var

# mkdir new-root
# ls
bin   dev  home  media  my-new-root  proc  run   srv  tmp  var
boot  etc  lib   mnt    opt          root  sbin  sys  usr

# cd my-new-root
<!-- 
Make copys of the OS inside here
Once inside, my-new-root can't access outside of it
therefore # chroot . bash won't work.
-->
# mkdir new-root/bin
# cp bin/bash my-new-root/bin
# ls new-root/bin
bin


<!-- 
bash has dependencies so before you can utilize it
you'll need to add library codes of modules
-->
# ldd bin/bash
	linux-vdso.so.1 (0x0000ffffa0b77000)
	libtinfo.so.5 => /lib/aarch64-linux-gnu/libtinfo.so.5 (0x0000ffffa09f8000)
	libdl.so.2 => /lib/aarch64-linux-gnu/libdl.so.2 (0x0000ffffa09e3000)
	libc.so.6 => /lib/aarch64-linux-gnu/libc.so.6 (0x0000ffffa088a000)
	/lib/ld-linux-aarch64.so.1 (0x0000ffffa0b4b000)


<!-- 
Make two directories for those dependencies
use "{}"
"," adds a dir that's just the prev segment 
"64" adds a dir that's just the prev segment 
-->
# mkdir new-root/lib{,64}
# ls new-root
bin  lib  lib64

<!-- 
Everything with paths visible in # ldd bin/bash
needs to be copied
lib64 doesn't exist on Apple M1 so I removed that dir
-->
# cp /lib/aarch64-linux-gnu/libtinfo.so.5  /lib/aarch64-linux-gnu/libdl.so.2  /lib/aarch64-linux-gnu/libc.so.6 	/lib/ld-linux-aarch64.so.1

# ls new-root/lib
ld-linux-aarch64.so.1  libc.so.6  libdl.so.2  libtinfo.so.5

# ls new-root/bin
chroot: failed to run command '/bin/sh': No such file or directory

<!-- Change root -->
# chroot new-root/ bash
bash-4.4#
# ls
bash: ls: command not found
<!-- There's nothing into bash so ls won't work -->

# pwd
/
# exit 
<!-- (gets you out of the chroot env to the ubuntu env) -->

<!-- Copy /bin/ls to new-root/bin -->
# cp /bin/ls new-root/bin/
<!-- Keep an eye on the slashes! -->
# lld /bin/ls


# cp /lib/aarch64-linux-gnu/libpcre.so.3 /lib/aarch64-linux-gnu/libpthread.so.0 /lib/aarch64-linux-gnu/libselinux.so.1 new-root/lib 

# ls
bin  lib


<!--
For cat, make sure all the dep have been added to the new
root. Then copy the library itself to the new root's lib
folder.
-->
# ldd /bin/cat
linux-vdso.so.1 (0x0000ffffa2b6c000)
	libc.so.6 => /lib/aarch64-linux-gnu/libc.so.6 (0x0000ffffa29ce000)
	/lib/ld-linux-aarch64.so.1 (0x0000ffffa2b40000)

linux-vdso.so.1


<!-- Alt: # cp ./bin/cat ./new-root/lib -->
# cp /bin/cat /new-root/lib
