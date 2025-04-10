# CDAPKG

…a controlled and reproducible CLI ecosystem.

- cdapkg is your under-the-hood router
- All installs follow cdapkg install <tool>
- All tools are rebuilt, linked, and maintained through cdapkg init

## Ecosystem Structure

``` 
/usr/local/cdaprod/
├── bin/                    # symlinks for global tools (repocate, cdaprodctl, cdactl, etc.)
├── share/                  # ASCII banners, man pages, plugin logos
├── etc/                    # static config templates and boot profiles
├── src/                    # source trees (for optional rebuilds)
├── tools/                 # actual tool installs (built or cloned)
│   ├── repocate/
│   ├── cdaprodctl/
│   └── cdactl/
└── init.d/
    ├── 00_env.sh          # sets paths, sourcing rules
    ├── 01_binmap.sh       # generates symlinks to /usr/local/bin
    └── 99_motd.sh         # shows ecosystem MOTD or bootstrap checklist
```   

## INSTALL FLOW (Single Trigger)

1. New machine
2. Run:

	- `curl -fsSL https://cdaprod.dev/bootstrap.sh | bash`
3.	Script does:

    - Installs cdapkg
    - Clones core repos (repocate, cdaprodctl)
    - Runs cdapkg init
    - You type repocate and it Just Works™

