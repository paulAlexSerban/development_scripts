Here is a complete, configurable Bash solution that automates switching between your personal and work GitHub profiles.

It handles **SSH keys**, **Git config identity (name/email)**, and optionally your **GPG signing keys**—either automatically when you navigate into a specific folder path, or manually via a quick CLI command.

---

## Step 1: Organize Your SSH Keys

To make this work seamlessly, ensure you have separate SSH keys generated for each profile (e.g., `~/.ssh/id_rsa_personal` and `~/.ssh/id_rsa_work`).

If you haven't done this yet, generate them using:

```bash
ssh-keygen -t ed25519 -C "your_personal_email@example.com" -f ~/.ssh/id_rsa_personal
ssh-keygen -t ed25519 -C "your_work_email@company.com" -f ~/.ssh/id_rsa_work

```

*Make sure both public keys are added to their respective GitHub accounts.*

---

## Step 2: The Core Bash Script

Add the following script to your shell configuration file (e.g., `~/.bashrc` or `~/.zshrc` if you use Zsh).

### Configuration Section
Create a file at `~/.git-profiles.json`:
```json
{
  "personal": {
    "name": "Your Name",
    "email": "personal@email.com",
    "ssh_key": "~/.ssh/id_rsa_personal",
    "path_keyword": "projects/personal",
    "gpg_key": ""
  },
  "work": {
    "name": "Work Name",
    "email": "work@company.com",
    "ssh_key": "~/.ssh/id_rsa_work",
    "path_keyword": "projects/work",
    "gpg_key": "ABC12345"
  }
}
```


## Step 3: Apply the Changes

After saving the configuration file, reload your terminal profile:

```bash
source ~/.bashrc   # Or source ~/.zshrc if using Zsh

```

---

## How to Use It
### Option A: The Automatic Way (Folder Paths)
Simply change directories in your terminal. The script tracks your path and shifts configurations dynamically:

```bash
cd ~/projects/work/some-repo
# Output: 🔄 Switched to WORK GitHub profile (your_work_email@company.com)

cd ~/projects/personal/my-side-project
# Output: 🔄 Switched to PERSONAL GitHub profile (your_personal_email@example.com)

```

Because the function is tied to the terminal hook, opening a new terminal window directly inside those directories will instantly configure the correct profile on startup.

### Option B: The Manual Way (CLI Command)
If you are working outside your dedicated directories, use the `gprofile` command to jump profiles manually:

```bash
gprofile work
gprofile personal

```

---
> 💡 **Pro-Tip for SSH Config:** If you use multiple accounts on the *same* machine for `github.com`, GitHub's SSH routing can sometimes get confused if you rely entirely on the SSH agent. To guarantee a perfect handoff, add this to your `~/.ssh/config`:
> ```text
> Host github.com
>   IdentityAgent identityAgent
>   IdentitiesOnly yes
> 
> ```
> 
> 
> This forces SSH to strictly use the active key currently loaded into your `ssh-agent` by the script above, rather than guessing or trying cached keys sequentially.
>

---

## Requirements
To use this you must have jq installed:

Mac: `brew install jq`
Ubuntu/Debian: s`udo apt install jq`