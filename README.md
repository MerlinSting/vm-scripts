# vm-scripts

## SMB Share Auto-Mount Script (Direct Execution)

This script automates mounting an SMB share on Linux and sets it to auto-mount on boot using `curl` and `bash` for direct execution.

**WARNING:** Directly executing scripts from the internet can be a security risk. Only proceed if you fully trust the script's source. Inspect the script on GitHub before execution.

### Instructions

1.  **Execute the script directly:**
    ```bash
    sudo bash <(curl -s [https://raw.githubusercontent.com/MerlinSting/vm-scripts/refs/heads/main/smb/setup_smb.sh](https://raw.githubusercontent.com/MerlinSting/vm-scripts/refs/heads/main/smb/setup_smb.sh))
    ```
    * Replace `yourusername` and `yourrepository` with your GitHub username and repository name.
    * Replace `main` with the branch that contains the script.
    * This command downloads and executes the script directly without saving it to disk.

2.  **Follow the prompts:** Enter the SMB share details, username, password, and UID/GID.

### Important Notes

* This script stores SMB credentials in `/etc/smbcredentials`. Be aware of the security implications.
* Ensure `cifs-utils` is installed.
* The script modifies `/etc/fstab` for auto-mounting.
