# XMRig Docker CPU-only

## Build Prerequisites
- Install kmod and msr-tools on the host system # is this required?
- `mv Dockerfile.[pve|ubuntu] Dockerfile` depending on your host.  Ubuntu is easier, but might not be as performant. I need to test this.

## User Settings - miner\_data/config.json
- user: Monero Wallet Address
- rig-id: Optional ID for each rig
- Go over all the settings...

## Usage Notes
The first time the container runs, XMRig will benchmark the algorithms and save the performance data to the config file. Once this is complete you can set `rebench-algo` to `false`.
