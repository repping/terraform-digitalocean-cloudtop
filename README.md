# Cloudtop: Virtual desktop environment in DO

Inspired by @robertdebock 's <https://github.com/robertdebock/ansible-playbook-cloudtop>

## Inside the box

- Creates Project in DO
- Creates a Fedora 36 droplet inside the project, accesable with a SSH private key.

## Roadmap

- [ ] mount persistant /home volume
  - make user supplied
  - [x] make it replace default home partition, see chapter home mount. --> replaced by just manually linking to a folder in the homedir.
- [x] configure domain (Cloudflare) + hostname
- [x] MERGE modules: sshkey and volume into droplet. the modules are too tiny to be useful as a standalone module.
  - [x] optioneel maken + user supplied maken, zie TODO en var.sshkey in main.tf.
- automation:
  - packages
    - awscli
    - ansible
    - terraform
    - tfenv
    - git
  - configure
    - vim default
    - user
    - ssh key
    - disable root login/pw login + create new personal user with same ssh key
    - seperate home volume automatically mounted @ /homn/user
  - optional
    - desktop environment
    - rdp
    - docker

## SSH key pair to connect to the droplet

Default: When no key is provided by the user; Terraform will generate one for you, upload it to Digital Ocean and place a copy of the public and private keys in `var.path` (defaults to ./files)

The user can supply their own ssh key by placing the files in `./files/<ssh_key_name.pub>` and declaring the `<ssh_key_name.pub>` for `var.key_name` in the root module.

## Home mount

The volume in Digital Ocean that will be used for the `home` mount has to be manually created first. This is because this mount will contain all our personal data and we want this data to persist recreation of the droplet. Sometimes you might not need the cloudtop for a longer period of time. This way you can keep the personal data without paying for the droplet in the mean time.

![Money!](https://i.pinimg.com/originals/d3/19/2b/d3192ba96881787f4737180f4d1f37ce.png)

To attach the volume to the droplet, simple declare `attach_volume_names` with a __list__ of volume names. The volume name was provided by the user when manually creating it in Digital Ocean.
The modules DOES assume that the manually created disks recide in the same region as the droplet!
Now that a persistant volume has been attached, it just needs to be partitioned and mounted.

### Manual partitioning

Note! In most cases partitioning should only be done once, the first time when no data has been written to the disk.
Repeating this when the disk has allready been partitioned likely erases all data, unless you know what you are doing :)

The partition and filesystem have to be manually created (for now):

```text
parted -s -a optimal /dev/sda mklabel gpt -- mkpart primary ext4 0% 100%
mkfs.ext4 /dev/sda1
```

Then on first boot mount the volume on `/home`:

```text
mount /dev/sda1 /home
```

By default the DigitalOcean fedora image comes with a small /home partition. This will stay available and can be accessed again by unmounting the seperate home volume. (Unless this partition is deleted ofcourse!)

### Manual mounting

( From the Digital Ocean instructions: )

```shell
mkdir -p /mnt/<VOLUME_NAME>; \
mount -o discard,defaults /dev/disk/by-id/scsi-0DO_Volume_<VOLUME_NAME> /mnt/<VOLUME_NAME>; \
echo /dev/disk/by-id/scsi-0DO_Volume_<VOLUME_NAME> /mnt/<VOLUME_NAME> ext4 defaults,nofail,discard 0 0 | sudo tee -a /etc/fstab
```

### Personal touch

I like to keep the volume mounted at `/mnt/cloudtop_persistent_volume` and create a link in my homefolder to the volume:

```shell
ln -s /mnt/cloudtop_persistent_volume/code /home/user/code
```
