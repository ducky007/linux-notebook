# p9-notes

## Internet

```
ndb/dns # start the dns resolver
ip/ipconfig # configure interfaces and get ip address with dhcp
ip/ping google.com # check internet connection
```

```
webfs # start a filesystem that handle urls
abaco 'http://google.com/search?q=plan9'
```

## Screen Recording

Sometimes it can be useful to record what's on your screen. For example, you can use screen shots for documentation. Also, providing a view of an error can help others to diagnose the problem. You can take a shot of the whole screen quite easily in a raw image format like this.

    cat /dev/screen > /tmp/shot.pic

The command concatenates the raster image currently on the screen and output to the file. You can open the image with the page tool. Careful 

    window page /tmp/shot.pic

If you want to give yourself some time to prepare the screen shot you can add a sleep in front of it and show a message when it is finished.

    sleep 10; cat /dev/screen > /tmp/shot.pic; echo Done

Plan 9's raw image format can take more disk space than something like GIF or PNG. Also, these formats are more easily recognized by the system in order to open the correct viewer. For these reasons you will often want to convert them right away.

    cat /dev/screen | topng > /tmp/shot.png

This concatenates the screen image and pipes it to the topng command, which as you can guess outputs a PNG version of the image. You can open this image by right-clicking directly on the image file path and type 'q' on the keyboard to quit. Let's compare the size of the two files. In my case, the PNG is easily 300 times smaller.

    ls -l /tmp/shot.png /tmp/shot.pic

We can even do screen recordings using a similar technique to produce an animated GIF. This command will take ten seconds of screen shots, one every 100ms, and compile them together into an animated gif.

    for (i in `{seq -w 1 12}) { sleep 0.01; cat /dev/screen > /tmp/screen-$i.pic }; togif -l -1 -d 300 /tmp/screen-*.pic > /tmp/recording.gif; rm /tmp/screen-*.pic; echo Done

The default gif viewer (called page) doesn't support gif animations. Let's view it with the gif tool. It recorded the whole screen and so you may need to resize the window to see all of the action that you recorded.

    window gif /tmp/recording.gif

In this tutorial we learned how to capture the screen and record it in either raw Plan 9 raster format or a common GIF format. You can read more about the available formats and options in gif(1). The GIF file format supports animation, allowing us to take multiple shots and record short videos.

## QEMU

First you need to create a virtual hard disk(.img) for qemu to install plan9 into.

    $ qemu-img create -f qcow2 9front.qcow2.img 20G

Now, boot the iso image:

    $ qemu-system-x86_64 -hda 9front.qcow2.img -cdrom ~/Documents/OS/9front/9front.iso -boot d -vga std -m 768 -net nic -net user

Just follow the instructions in the 9front install wiki page. You start the installation by doing inst/start. Once installation is done, stop the qemu reboot and start with the following switches.

## Git

    hget http://plan9.stanleylieber.com/rc/git > $home/bin/rc/git

## Themeing
    
    hget http://plan9.stanleylieber.com/src/rio.mono.tgz > $home/rio.mono.tgz
    tar zxf rio.mono.tgz
    cd rio.mono
    mk install

To add this version of rio to open on launch.

    $home/lib/profile

Now head over to #cat-v to be made fun of.


