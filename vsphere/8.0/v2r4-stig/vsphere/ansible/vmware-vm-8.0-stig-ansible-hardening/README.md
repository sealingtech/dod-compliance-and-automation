# vmware-vm-8.0-stig-ansible-hardening
## NOTICE
This playbook is currently not maintained by the VMware team with no support provided.

## Overview

VMware vSphere VM 8.0 STIG Readiness Guide Ansible Playbook

Version: Version 2 Release 1

STIG Type: STIG Readiness Guide

## Tool Requirements
- Tested with Ansible core 2.14.0
- community.vmware Ansible Collection (installs pyVmomi as a dependency)
- pyVmomi (used directly by `files/vmware_vm_configspec.py` for the handful of
  controls not expressible through the community.vmware collection)
- PowerCLI (latest) + PowerShell Core 7.2 — needed only for the initial VM
  hostname discovery step, not for any individual STIG control

## Role Requirements
- Role contains a `requirements.yml` (use Ansible Galaxy to install dependencies)

## Playbook Structure
- playbook.yml (the playbook to run the role/tasks)
- tasks/vmch_80_stig_remediation.yml (the STIG remediation tasks)
- vars/vmch_80_stig_vars.yml (connection settings, remediation values, per-check toggles)
- files/vmware_vm_configspec.py (pyVmomi helper for controls with no
  community.vmware equivalent — see table below)

## How to Run
**Note**: Variables need to be configured prior to execution (ex: vcenter_username)

Example of running role
```
ansible-playbook -i inventory_file playbook.yml -v --ask-vault -K
```

Example of running individual lockdowns
```
ansible-playbook -i inventory_file playbook.yml --tag VMCH-80-000189,VMCH-80-000191 -v --ask-vault -K
```

## STIG Control Coverage
- Enabled means the playbook will run it by default
- Manual means it is either a policy control or a technical control that must be manually addressed due to its need for human review (typically because it requires the VM to be powered off or environment-specific judgment)
- Ansible VMware Module means it leverages the community.vmware Ansible Collection (no PowerCLI/pwsh involved)
- Python (pyVmomi) means it uses a plain Python script talking to the vSphere API directly — used only where the community.vmware collection has no equivalent parameter (vMotion encryption, Fault Tolerance encryption, and the VM logging flag are ConfigSpec properties, not advanced settings)
- PowerShell/PowerCLI means it uses shell to call pwsh, which in turn calls PowerCLI — not used by any control in this version; retained as a column for parity with the 7.0 playbook, and because the VM hostname discovery step (not a STIG control itself) still uses it

|STIG ID       |Enabled?          |Manual?           |Ansible VMware Module|Python (pyVmomi)  |PowerShell/PowerCLI|
|--------------|------------------|------------------|---------------------|-------------------|-------------------|
|VMCH-80-000189|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000191|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000192|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000193|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000194|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000195|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000196|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000197|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000198|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000199|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000200|:x:               |:heavy_check_mark:|:x:                  |:x:                |:x:                |
|VMCH-80-000201|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000202|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000203|:heavy_check_mark:|:x:               |:x:                  |:heavy_check_mark: |:x:                |
|VMCH-80-000204|:heavy_check_mark:|:x:               |:x:                  |:heavy_check_mark: |:x:                |
|VMCH-80-000205|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000206|:heavy_check_mark:|:x:               |:heavy_check_mark:   |:x:                |:x:                |
|VMCH-80-000207|:heavy_check_mark:|:x:               |:x:                  |:heavy_check_mark: |:x:                |
|VMCH-80-000208|:x:               |:heavy_check_mark:|:x:                  |:x:                |:x:                |
|VMCH-80-000209|:x:               |:heavy_check_mark:|:x:                  |:x:                |:x:                |
|VMCH-80-000210|:x:               |:heavy_check_mark:|:x:                  |:x:                |:x:                |
|VMCH-80-000211|:x:               |:heavy_check_mark:|:x:                  |:x:                |:x:                |
|VMCH-80-000212|:x:               |:heavy_check_mark:|:x:                  |:x:                |:x:                |
|VMCH-80-000213|:x:               |:heavy_check_mark:|:x:                  |:x:                |:x:                |
|VMCH-80-000214|:x:               |:heavy_check_mark:|:x:                  |:x:                |:x:                |
