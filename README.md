# kc-bash

A personal Bash helper function script. Not publicly supported or for production use.

## Add kc-bash to a script:

```
. <(curl -s https://raw.githubusercontent.com/CaseyLabs/kc-bash/main/kc-bash.sh)
```

You can also pin the script to a specific git tag/release version:
```
KC_VERSION="0.0.1"
. <(curl -s https://raw.githubusercontent.com/CaseyLabs/kc-bash/v${KC_VERSION}/kc-bash.sh)
```

## Available functions:

| Command    | Description                  | Example                  |
|------------|------------------------------|--------------------------|
| dirExists  | Checks if a directory exists | `dirExists /etc/ `       |
| fileExists | Checks if a file exists      | `fileExists /etc/passwd` |
| get        | Installs a system package    | `get curl wget gcc`      |