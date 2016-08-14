# raspberrypi-images
Base Raspberry Pi images

## Creating a new base image

Create a fresh and up-to-date [Raspian] + [Adafruit Occidentalis]. The system is hostname and WiFi configurable. Simply insert your disk into a card reader and edit `occidentalis.txt` accordingly.

Note that the plain shell prefix `$` denotes the host.

1. Grab [Raspian Jessie Lite] to use as our base image.
1. Write the image to disk (might need `sudo`)
```
$ dd if=2016-05-27-raspbian-jessie-lite.img of=/dev/rdiskX
```
1. Boot the pi using a wired internet connection
1. SSH into the pi `ssh pi@xxx.xxx.xxx.xxx`
  1. Survey your network for possible IPs with something like `arp -i en0 -a | grep -v incomplete`
  1. [Optional] Once identified, install your SSH key
  ```
  $ ssh-copy-id pi@xxx.xxx.xxx.xxx
  ```
1. Run the [Adafruit Occidentalis] bootstrapper
  1. Inspect and verify the [install script]
  1. Run it
```
pi@raspberrypi:~ $ curl -SLs https://apt.adafruit.com/install | sudo bash
```
1. Copy the [example Occidentalis configuration] to `/boot/occidentalis.txt` for easy editing (e.g. from a card reader on the host)
```
pi@raspberrypi:~ $ sudo cp /usr/share/doc/occi/occidentalis_example.txt /boot/occidentalis.txt
```
1. [Optional] Set (or unset) the hostname and/or WiFi credentials in `/boot/occidentalis.txt`
1. Create the disk image using a card reader
  1. Shutdown the pi with `sudo shutdown -h now`
  1. Insert the disk into the host's card reader
  1. Create the image
  ```
  $ sudo dd bs=1m if=/dev/rdiskX | gzip > raspberrypi.img.gz
  ```
  1. Test the image by restoring it to a different disk
  ```
  $ gzip -dc raspberrypi.img.gz | sudo dd bs=1m of=/dev/rdiskX
  ```

[Raspian]: (https://www.raspberrypi.org/downloads/raspbian/)
[Raspian Jessie Lite]: (https://www.raspberrypi.org/downloads/raspbian/)
[Adafruit Occidentalis]: (https://github.com/adafruit/Adafruit-Occidentalis)
[install script]: (https://github.com/adafruit/Adafruit-Occidentalis/blob/master/install.sh)
[example Occidentalis configuration]: (https://github.com/adafruit/Adafruit-Occi/blob/master/usr/share/doc/occi/occidentalis_example.txt)
