# XMRig Docker CUDA-only

## Build Prerequisites
- Install kmod and msr-tools on the host system # is this required?
- Install the nvidia runtime for docker on the host system
- Install the exact same versions of cuda on the host as specified in the Dockerfile.  Upgrade/Downgrade either as appropriate for your nvidia card

## User Settings - miner\_data/config.json
- user: Monero Wallet Address
- rig-id: Optional ID for each rig

## Usage Notes
The first time the container runs, XMRig will benchmark the algorithms and save the performance data to the config file. Once this is complete you can set `rebench-algo` to `false`.
