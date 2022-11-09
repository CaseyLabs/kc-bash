# CaseyBash

A personal Bash helper function script. Not publicly supported or for production use.

## Download CaseyBash script:

```
# If CaseyBash does not exist, then install:

CASEY_INSTALL_DIR="${HOME}/.config/caseybash"
if [ ! -f ${CASEY_INSTALL_DIR}/caseybash.sh ]; then
  mkdir -p ${CASEY_INSTALL_DIR}
  curl https://raw.githubusercontent.com/CaseyLabs/CaseyBash/main/caseybash.sh -o ${CASEY_INSTALL_DIR}/caseybash.sh
fi
```

## Add CaseyBash to a script:

```
#!/usr/bin/env bash

source ${HOME}/.config/caseybash/caseybash.sh
```