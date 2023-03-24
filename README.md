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

| Command    | Description                                | Example                  |
|------------|--------------------------------------------|--------------------------|
| checkapp   | Check if an application exists             | `checkapp myAppName`     |
| checkdir   | Checks if a directory exists               | `checkdir /etc/ `        |
| checkfile  | Checks if a file exists                    | `checkfile /etc/passwd`  |
| ecrlogin   | Logs into the current AWS ECR account.     | `ecrlogin`               |
| get        | Installs a Linux system package            | `get curl wget gcc`      |
| upgrade    | Upgrades all Linux system packages         | `upgrade`                |
| myip       | Prints your internal IP                    | `myip`                   |
| mypublicip | Prints your external IP                    | `mypublicip`             |
| replace    | Finds and replaces text in file            | `replace originalText newText /path/to/file.txt` |
| awsaccount | Prints the AWS account you are logged into | `awsaccount`             |
| services   | Prints RUNNING services on system          | `services`               |
| unzipg     | uncompresses a tar/gzip file               | `unzipg myFile.tar.gz /destination/path` |
