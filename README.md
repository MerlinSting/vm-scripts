# vm-scripts
## Useful Links

1. https://github.com/community-scripts/ProxmoxVE

## SMB Share Auto-Mount Script (Direct Execution)

This script automates mounting an SMB share on Linux and sets it to auto-mount on boot using `curl` and `bash` for direct execution.

**WARNING:** Directly executing scripts from the internet can be a security risk. Only proceed if you fully trust the script's source. Inspect the script on GitHub before execution.

### Instructions

1.  **Execute the script directly:**
    ```bash
    sudo bash <(curl -s [https://raw.githubusercontent.com/MerlinSting/vm-scripts/refs/heads/main/smb/setup_smb.sh](https://raw.githubusercontent.com/MerlinSting/vm-scripts/refs/heads/main/smb/setup_smb.sh))
    ```

2.  **Follow the prompts:** Enter the SMB share details, username, password, and UID/GID.

### Important Notes

* This script stores SMB credentials in `/etc/smbcredentials`. Be aware of the security implications.
* Ensure `cifs-utils` is installed.
* The script modifies `/etc/fstab` for auto-mounting.
