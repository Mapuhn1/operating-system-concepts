# Assignement 1– Task 1 & Task 2

## Author Details
- **Full Name:** Hazel Mapuranga
- **Login name:** mapuhn
- **Last Modified:** 16/09/2025 

---


## Script Overview - Task1

| Script         | Purpose                                                                 |
|----------------|-------------------------------------------------------------------------|
| `user_setup.sh` | This is the main execution file which combines all functions to create users with provided details, setup their groups and shared folders and settting up aliases for users that are sudoers| 
| `folders.sh`      | Sets up a shared folder, creates a matching group, adds the user to it, and links the folder into their home  |
| `user.sh`         | It generates a username from an email, a password from a birth date, and after usear creation it forces a password change on first login  |
| `groups.sh`       | Ensures the specified groups exist and adds the user to them|
| `input.sh`       | Checks the input file and prompts user they wnat to continue with execution if the file input exists |
| `logging.sh`       | Logs actions parsed as first argument with timestamp and appends to logfile |
| `aliases.sh`      | Checks if user is apart of sudo group and creates alias `myls` to run `ls -la` |



---

## Pre-requisites

Before running any scripts, ensure the following:

- You have **sudo privileges** on the system.
- The input CSV file is formatted as:  
  `email,birthdate,groups,sharedFolder`
- All scripts are executable:  
  ```bash
   chmod +x user.sh folders.sh user_setup.sh logging.sh input.sh groups.sh aliases.sh

## Usage 

### Quick Setup
1. **Clone this repository** to your home directory
2. **Create an alias** for easy execution:
```bash
   alias task1='cd ~/operating-system-concepts/assignment1/task1 && ./user_setup.sh'
```
## Input Files ( 2 Options)

- **URI** - A link to the user web based csv file: 
` https://osc.op-bit.nz/share/users.csv`

- **Local File** -  A local file system location e.g. `/home/<your-username>/files/users.csv` containing: 
```
e-mail,birth date,groups,sharedFolder
edsger.dijkstra@tue.nl,1930/05/11,sudo,staff,/staffData
john.mccarthy@caltech.edu,1927/09/04,sudo,visitor,/visitorData
andrew.tanenbaum@vua.nl,1944/03/16,staff,/staffData
alan.turing@cam.ac.uk,1912/06/23,visitor,/visitorData
linus.torvalds@linux.org,1969/12/28,sudo,
bjarne.stroustroup@tamu.edu,1950/12/30,,/visitorData
ken.thompson@google.com,1973/02/04,sudo,visitor,
james.gosling@sun.com,1955/05/19,staff,/staffData
tim.berners-lee@mit.edu,1955/06/08,sudo,visitor,/visitorData
```

## Script Overview - Task2

| Script         | Purpose                                                                 |
|----------------|-------------------------------------------------------------------------|
| `backup_script.sh` | This is the main execution file which combimes all functions to create directory backup and uploading it to a remote server| 
| `backup.sh`      | Creates a compressed tar archive of the backup directory and logs to log file  |
| `input.sh`         | Checks the backup directory parsed as input by the user then prepares archive and prompts for their remote login details |
| `logging.sh`       | Logs actions parsed as first argument with timestamp and appends to logfile |
| `upload.sh`       | Uploads the backup archive to a remote server over SCP and logs the outcome |


---

## Pre-requisites

Before running any scripts, ensure the following:

- All scripts are executable:  
  ```bash
   chmod +x backup_script.sh backup.sh input.sh logging.sh upload.sh

## Usage 

### Quick Setup
1. **Clone this repository** to your home directory
2. **Create an alias** for easy execution:
```bash
   alias task2='cd ~/operating-system-concepts/assignment1/task2 && ./backup_script.sh'
```
## Input File

- **Local File** -  A directory in your localfile system location that you want to be backued up e.g. 
`/home/group-x/remote`
> You will be prompted to enter you remote login credentials e.g.
```

Enter remote server IP/hostname: 0.0.0.0
Enter port: 22
Enter username: mapuhn
Enter remote directory: /home/group-x/remote
Mon Sep 15 05:48:28 UTC 2025: Uploading to mapuhn@0.0.0.0:/home/group-x/remote
mapuhn@4.197.56.10's password:

