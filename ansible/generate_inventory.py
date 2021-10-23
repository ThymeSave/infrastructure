#!/usr/bin/env python3

import argparse
import getpass
import logging
import os
import socket

import oci

logging.basicConfig(level=logging.INFO)

parser = argparse.ArgumentParser("Inventory generator")
parser.add_argument("--bastion-id",
                    default="ocid1.bastion.oc1.eu-frankfurt-1.amaaaaaayfpniiaa4d7af3vq2jlhycxvoxt7o7ofrf7b7oulwdpzmml2ah4q")
parser.add_argument("--compartment-id",
                    default="ocid1.tenancy.oc1..aaaaaaaaggzs7vxv6gfidm5uqngz72leypa5qlmkhksd3zeld4pq4qjwopqq")
parser.add_argument("--username", default="opc")
parser.add_argument("--oci-config-file", default="~/.oci/config")
parser.add_argument("--oci-config-profile", default="DEFAULT")
parser.add_argument("--public-key-path", default="~/.ssh/id_rsa.pub")
parser.add_argument("--session-ttl",default=10800)
args = parser.parse_args()

with open(os.path.expanduser(args.public_key_path), "r") as pub_key_file:
    public_key = "".join(pub_key_file.readlines())

logging.info("Read oracle config and create required clients")
config = oci.config.from_file(args.oci_config_file, args.oci_config_profile)
identity = oci.identity.IdentityClient(config)
user = identity.get_user(config["user"]).data
bastion = oci.bastion.BastionClient(config, retry_strategy=oci.retry.DEFAULT_RETRY_STRATEGY)
compute = oci.core.ComputeClient(config, retry_strategy=oci.retry.DEFAULT_RETRY_STRATEGY)

hosts = []

logging.info("Creating bastion sessions")
for instance in compute.list_instances(args.compartment_id).data:
    logging.info(f"Creating bastion session for {instance.display_name}({instance.id}")

    session = bastion.create_session(
        create_session_details=oci.bastion.models.CreateSessionDetails(
            bastion_id=args.bastion_id,
            target_resource_details=oci.bastion.models.CreateManagedSshSessionTargetResourceDetails(
                target_resource_id=instance.id,
                session_type="MANAGED_SSH",
                target_resource_operating_system_user_name=args.username,
                target_resource_port=22
            ),
            key_details=oci.bastion.models.PublicKeyDetails(
                public_key_content=public_key
            ),
            display_name=f"{getpass.getuser()}@{socket.getfqdn()}",
            key_type="PUB",
            session_ttl_in_seconds=int(args.session_ttl)
        )
    )

    hosts.append({
        'name': instance.display_name,
        'sshUri': "{0}@host.bastion.eu-frankfurt-1.oci.oraclecloud.com".format(session.data.id),
        'user': args.username
    })

logging.info("Generate inventory")
with open("inventory/inventory.ini", "w") as inventory_file:
    inventory_file.write("[nodes]\n")
    for host in hosts:
        inventory_file.write(host["name"])
        inventory_file.write(
            f' ansible_ssh_common_args="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ProxyCommand=\\"ssh -W %h:%p -p 22 {host["sshUri"]}\\""')
        inventory_file.write(f' ansible_user={host["user"]}')
        inventory_file.write("\n")
