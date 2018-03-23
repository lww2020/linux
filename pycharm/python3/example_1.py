#!/usr/bin/env python3
# -*- coding:utf-8 -*-
# Author: davie
import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy)
ssh.connect(hostname='192.168.65.130',port=22,username='root',password='1qazxsw2')
stdin, stdout, stderr = ssh.exec_command('cat /tmp/1.txt')
print(stdout.readlines())
ssh.close()