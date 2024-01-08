# autossh_win

## Requirements
Ensure your system meets the following prerequisites before using `autossh_win`:
1. **Compatible Windows Version**: The script is compatible with Windows 10, 11, Server 2019, and Server 2022 with OpenSSH installed.
2. **Administrator Rights**: You must have administrative privileges on your system.
3. **Prepared sshd_config**: Your `sshd_config` file should have the following settings enabled:
    - `AllowTcpForwarding yes`
    - `GatewayPorts yes`

## Usage
To use `autossh_win`, execute the provided batch file with the required parameters. Here is an example for a single usage:

`.\autossh.bat root 192.168.0.100 3389 3390 2222 60 10`

### Parameter Explanation
- `root`: SSH user
- `192.168.0.100`: SSH server address
- `3389`: Local port to be forwarded (e.g., RDP port)
- `3390`: Destination port on the remote server
- `2222`: SSH port (leave empty if default)
- `60`: `ClientAliveInterval` as configured in your remote server's `sshd_config` (can be left empty)
- `10`: `ClientAliveCountMax` as configured in your remote server's `sshd_config` (can be left empty)

Replace the parameters with your specific configuration details when running the script.


## Automatic Startup Using Windows Task Scheduler

To set up the `autossh_win` script to automatically run at system startup using the Windows Task Scheduler, follow these steps:

1. **Open Task Scheduler**:
   - Press `Win + R`, type `taskschd.msc`, and press Enter.
   - Alternatively, search for "Task Scheduler" in the Start menu.

2. **Create a New Task**:
   - In the Task Scheduler, go to `Action` > `Create Task...` to open the Create Task window.

3. **General Settings**:
   - Name the task (e.g., `AutoSSHStartup`).
   - Choose `Run whether user is logged on or not` if you want the script to run without a user session.
   - Select `Run with highest privileges` to ensure the script has the necessary permissions.

4. **Triggers**:
   - Go to the `Triggers` tab and click `New...`.
   - Set `Begin the task:` to `At startup`.
   - Configure additional settings as needed and click `OK`.

5. **Actions**:
   - Switch to the `Actions` tab and click `New...`.
   - Set `Action:` to `Start a program`.
   - In `Program/script`, enter the path to your `autossh.bat` script.
   - Add any necessary arguments in the `Add arguments` field.
   - Click `OK` to save the action.

6. **Conditions and Settings**:
   - Adjust settings in the `Conditions` and `Settings` tabs as needed for your specific requirements.

7. **Save the Task**:
   - Click `OK` to save and schedule your new task.
   - Enter your credentials if prompted.

The script will now automatically execute at each system startup, running the SSH tunnel as configured.
