# raspberrypi-images
Base Raspberry Pi images

## Creating a new base images

### TL;DR

From within a fresh Raspian install, run the [user data script]. Then shutdown and image the disk.

```
curl -SLs https://raw.githubusercontent.com/Mystopia/raspberrypi-images/master/scripts/user-data.sh | sudo bash
```

### Guided
Create a fresh and up-to-date [Raspian] + [Adafruit Occidentalis]. The system is hostname and WiFi configurable. Simply insert your disk into a card reader and edit `occidentalis.txt` accordingly.

Note that the plain shell prefix `$` denotes the host.

1. Grab [Raspian Jessie Lite] to use as our base image.
1. Write the image to disk (might need `sudo`)
  ```
  $ dd if=2016-05-27-raspbian-jessie-lite.img of=/dev/rdiskX
  ```

  1. Once completed, safely eject and remove the disk.
1. Using the fresh disk we just created, boot the pi with a wired internet connection.
1. SSH into the pi `ssh pi@xxx.xxx.xxx.xxx`
  1. Survey your network for possible IPs with something like `arp -i en0 -a | grep -v incomplete`
  1. [Optional] Once identified, install your SSH key
  ```
  $ ssh-copy-id pi@xxx.xxx.xxx.xxx
  ```

1. Run our [user data script].
  ```
  pi@raspberrypi:~ $ curl -SLs https://raw.githubusercontent.com/Mystopia/raspberrypi-images/master/scripts/user-data.sh | sudo bash
  ```

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
[user data script]: (https://github.com/Mystopia/raspberrypi-images/blob/master/scripts/user-data.sh)
