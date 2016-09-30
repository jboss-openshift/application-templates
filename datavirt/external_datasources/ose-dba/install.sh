#!/bin/bash

set -x

source /usr/local/s2i/install-common.sh

injected_dir=$1

install_modules ${injected_dir}/injected-modules

configure_drivers ${injected_dir}/install.properties

