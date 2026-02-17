[![Docker Pulls](https://img.shields.io/docker/pulls/mitexleo/openvas.svg)](https://hub.docker.com/r/mitexleo/openvas/)
[![Docker Stars](https://img.shields.io/docker/stars/mitexleo/openvas?style=flat)](https://hub.docker.com/r/mitexleo/openvas/)
[![Docker Stars](https://img.shields.io/docker/image-size/mitexleo/openvas.svg?maxAge=2592000)](https://hub.docker.com/r/mitexleo/openvas/)
[![GitHub Issues](https://img.shields.io/github/issues-raw/mitexleo/openvas.svg)](https://github.com/mitexleo/openvas/issues)
[![Discord](https://img.shields.io/discord/809911669634498596?label=Discord&logo=discord)](https://discord.gg/DtGpGFf7zV)
[![Twitter Badge](https://badgen.net/badge/icon/twitter?icon=twitter&label)](https://twitter.com/mitexleo)
![GitHub Repo stars](https://img.shields.io/github/stars/mitexleo/openvas?style=social)

# A Greenbone Vulnerability Management docker image
### Brought to you by ###

[Buy Me a Coffee](https://bmc.link/mitexleo)  
[Patreon](https://patreon.com/mitexleo)

## Documentation ##
The current container docs are maintained on github [here](https://mitexleo.github.io/openvas/)

For docs on the web interface and scanning, use Greenbone's docs [here](https://docs.greenbone.net/GSM-Manual/gos-22.04/en/). Chapter's 8-14 cover the bits you'll need.
- - - -

# Docker Tags  #
tag              | Description
----------------|-------------------------------------------------------------------
25.12.26.01 | This is the latest based on GVMd 24 available on x86_64 and arm64.
21.04.09 | This is the last 21.4 build.  
20.08.04.6 | The last 20.08 image
pre-20.08   | This is the last image from before the 20.08 update. 
v1.0             | old out of date image for posterity. (Dont` use this one. . . . ever)

# Greenbone Versions in Latest image: #
Component | Version | | Component | Version
----------|----------|-|----------|---------
| gvmd | v26.12.1 | | gvm_libs | v22.34.1 |
| openvas | v23.35.3 | | openvas_smb | v22.5.10 |
| notus_scanner | v22.7.2 | | gsa | v26.7.0 |
| gsad | v24.12.1 | | ospd | v21.4.4 |
| ospd_openvas | v22.10.0 | | pg_gvm | v22.6.12 |
| python_gvm | v26.8.0 | | gvm_tools | v25.4.4 |
| greenbone_feed_sync | v25.1.7 |

# 25 August 2023 #
## Discussions!!! ##

Moving forward, all new versions and any other changes will be posted in the [Announcements](https://github.com/mitexleo/openvas/discussions). The contents of this Readme will be preserved as [OldReadme.md](https://github.com/mitexleo/openvas/blob/master/OldReadme.md). 

Thanks,
Scott

- - - -




For License info, see the [GNU Affero](https://github.com/mitexleo/openvas/blob/master/LICENSE) license.
