#!/usr/bin/env bash

set -euo pipefail

sudo swapoff -a

sudo sed -i '/swap/s/^/# /' /etc/fstab


