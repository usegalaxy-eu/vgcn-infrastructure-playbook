# VGCN Infrastructure Playbook
## What this does
- Install and configure HTCondor, based on group based variables
- Add HTCondor Token for EU
- Install AutoFS and configure mountpoints
- Add a Telegraf `output.conf` with Galaxy Europe's Telegraf credentials
## Requirements
- Vault password
- Mountpoints variables from https://github.com/usegalaxy-eu/mounts
