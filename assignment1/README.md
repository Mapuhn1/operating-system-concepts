# Operating System Concepts - Hazel Mapuranga

This set of Bash scripts automates the creation of user accounts, assigns shared folders, and configures group permissions for onboarding workflows. Each script is modular and designed for reuse across environments.

---

## Script Overview - Task1

| Script         | Purpose                                                                 |
|----------------|-------------------------------------------------------------------------|
| `user_setup.sh` |  |
| `folders.sh`      |  |
| `user.sh`         |  |
| `groups.sh`       |  |
| `input.sh`       |  |
| `logging.sh`       |  |



---

## Pre-requisites

Before running any scripts, ensure the following:

- You have **sudo privileges** on the system.
- The input CSV file is formatted as:  
  `email,birthdate,groups,sharedFolder`
- All scripts are executable:  
  ```bash
   chmod +x user.sh folders.sh user_setup.sh logging.sh input.sh groups.sh
