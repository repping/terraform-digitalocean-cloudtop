# Cloudtop: Virtual desktop environment in DO
Inspired by @robertdebock 's https://github.com/robertdebock/ansible-playbook-cloudtop

1. Checkout the folder `support_code` to create pre-requirements for the Cloudtop deployment.

## Inside the box

- Creates Project in DO
- Creates a Fedora 36 droplet inside the project, accesable with a SSH private key.

## Roadmap

- mount persistant /home volume
  - make user supplied
  - AND/OR integrate in seperate tf root module "support-code"
  - make it replace default home partition, see chapter home mount.
- [x] configure domain (Cloudflare) + hostname
- [ ] merge modules: sshkey and volume into droplet
  - [ ] optioneel maken + user supplied maken, zie TODO en var.sshkey in main.tf.
- [ ] merge modules: project into root module
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

A seperate volume for the `/home` mount can be created with the code in `support_code`.
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
