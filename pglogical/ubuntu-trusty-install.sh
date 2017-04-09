#!/bin/sh
set -e

#
#  Copyright 2017 Andrey Anshin

#  Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

echo
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


. /etc/lsb-release
if [ "$DISTRIB_CODENAME" != "trusty" ]; then
   echo "This script only supported Ubuntu 14.04 LTS at that moment." 1>&2
   exit 2
fi


echo "!!! DO NOT USE FOR UPGRATE YOUR CURRENT POSTGRESQL INSTANCE !!! "
echo "Use that script only for fresh installation"
echo
read -p "For continue executing please write 'yes': " response
echo
if [ "$response" != "yes" ]; then
    echo "Terminating execution"
    exit 3
fi


echo "Add PostgreSQL repo key"
echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/postgresql.list
wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

echo "Add pglogical repo & key"
echo "deb [arch=amd64] http://packages.2ndquadrant.com/pglogical/apt/ trusty-2ndquadrant main" > /etc/apt/sources.list.d/2ndquadrant.list
wget -qO - http://packages.2ndquadrant.com/pglogical/apt/AA7A6805.asc | apt-key add -

sleep 1

echo "Update apt index cache"
apt-get update

apt-get install postgresql-9.6 postgresql-9.6-pglogical -y
