Ansible
===

## Setup

1. [Make sure you have installed and configure Oracle Cloud CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm)
2. Generate the inventory (valid for 3 hours): `./generate_inventory.py`
3. Install dependencies from Ansible Galaxy: `ansible-galaxy install -r requirements.yml`
4. Create `.vault-pasword` with vault secret

## Apply

Choose the playbook you want to run and execute it: `ansible-playbook playbook.yml`
