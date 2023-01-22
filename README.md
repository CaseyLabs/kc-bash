# CaseyBash

A personal Bash helper function script. Not publicly supported or for production use.

## Add CaseyBash to a script:

```
#!/usr/bin/env bash

KC_INSTALL_DIR="${HOME}/.config/kc-bash"
if [[ -f "$KC_INSTALL_DIR/kc-bash.sh" ]]
  . $KC_SRC/kc-bash.sh
else
  mkdir -p $KC_SRC
  curl https://raw.githubusercontent.com/CaseyLabs/kc-bash/main/kc-bash.sh -o ${KC_INSTALL_DIR}/kc-bash.sh
  . $KC_SRC/kc-bash.sh
fi
```