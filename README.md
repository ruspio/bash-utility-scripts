# bash-utility-scripts

Practical Bash utility scripts for Linux maintenance, desktop configuration, and small automation tasks.

This repository contains small Bash scripts created, reviewed, and improved as reusable command-line utilities.

## Scripts

| Script                  | Description                                                                       |
| ----------------------- | --------------------------------------------------------------------------------- |
| `upgrade_script.sh`     | Runs a full APT maintenance sequence: `update`, `dist-upgrade`, and `autoremove`. |
| `touch-pad-settings.sh` | Shows or changes the GNOME touchpad `send-events` setting.                        |

## Requirements

General requirements:

* Linux
* Bash
* Basic command-line environment

Script-specific requirements:

* `upgrade_script.sh`

  * Debian/Ubuntu-based system
  * `apt-get`
  * `sudo`, unless run as root

* `touch-pad-settings.sh`

  * GNOME desktop environment
  * `gsettings`

## Usage

### `upgrade_script.sh`

Runs:

1. `apt-get update`
2. `apt-get dist-upgrade -y`
3. `apt-get autoremove -y`

Example:

```bash
./upgrade_script.sh
```

The script automatically uses `sudo` when it is not run as root.

### `touch-pad-settings.sh`

Show current touchpad status:

```bash
./touch-pad-settings.sh
```

or:

```bash
./touch-pad-settings.sh --status
```

Enable touchpad:

```bash
./touch-pad-settings.sh --enable
```

Disable touchpad:

```bash
./touch-pad-settings.sh --disable
```

Disable touchpad only when an external mouse is connected:

```bash
./touch-pad-settings.sh --disabled-on-mouse
```

Show help:

```bash
./touch-pad-settings.sh --help
```

## Making scripts executable

After cloning the repository, make the scripts executable:

```bash
chmod +x upgrade_script.sh touch-pad-settings.sh
```

## Repository structure

```text
bash-utility-scripts/
├── README.md
├── upgrade_script.sh
└── touch-pad-settings.sh
```

## Notes

These scripts are intentionally simple, readable, and practical.
They are meant to be easy to understand, modify, and reuse.

The goal of this repository is not to provide a large framework, but a clean collection of small Bash utilities that solve real everyday problems.

## License

MIT License
