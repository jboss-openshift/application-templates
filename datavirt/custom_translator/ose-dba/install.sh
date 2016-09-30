#!/bin/bash

set -x

source /usr/local/s2i/install-common.sh
source /usr/local/s2i/install-teiid-common.sh

injected_dir=$1

install_modules ${injected_dir}/injected-modules

configure_translators ${injected_dir}/install.properties

