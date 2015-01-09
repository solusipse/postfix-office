#!/usr/bin/perl

# ########################################################################### #
# This file is part of postfix-office suite.
# For more informations visit:
#   https://github.com/solusipse/postfix-office
# ########################################################################### #

# --------------------------------------------------------------------------- #
# The MIT License (MIT)
#
# Copyright (c) 2014 solusipse
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# --------------------------------------------------------------------------- #

# -----------------------------------------------------------------------------
# This script is used for installing dependences via package managers.
# -----------------------------------------------------------------------------

package Install;

use strict;
use warnings;

use Tie::File;

sub detect_distribution {
    if (-e "/etc/redhat-release") {
        return 0;
    }
    if (-e "/etc/debian_version") {
        return 1;
    }

    Common::error(4);
}

sub detect_info {
    if (-e "/etc/redhat-release") {
        Common::display(5);
    }
    if (-e "/etc/debian_version") {
        Common::display(6);
    }
}

sub update_system {
    if (detect_distribution == 0) {
        centos_postfix_installer();
        system("yum update");
    }
    if (detect_distribution == 1) {
        system("apt get update && apt get upgrade");
    }
}

sub package_manager {
    if (detect_distribution == 0) {
        return "yum install ";
    }
    if (detect_distribution == 1) {
        return "apt get install "
    }
}

sub centos_postfix_installer {
    # Postfix from Base repository is compiled without PostgreSQL support.
    # This script forces yum to install Postfix from Centos Plus repository.

    Common::display(8);
    <STDIN>;

    system("yum remove postfix");

    tie my @array, 'Tie::File', "/etc/yum.repos.d/CentOS-Base.repo" or die "Can't open repository config file";

    for (my $i = 0;  $i < @array; $i++) {
        # TODO: improve that method to detect if there's includepkgs line already
        if ($array[$i] eq "[centosplus]") {
            if ($array[$i+1] ne "includepkgs=postfix*"){
                splice @array, $i+1, 0, 'includepkgs=postfix*';
            }
        }
        if ($array[$i] eq "[base]") {
            if ($array[$i+1] ne "exclude=postfix*"){
                splice @array, $i+1, 0, 'exclude=postfix*';
            }
        }
        if ($array[$i] eq "[updates]") {
            if ($array[$i+1] ne "exclude=postfix*"){
                splice @array, $i+1, 0, 'exclude=postfix*';
            }
        }
        if ($array[$i] eq "enabled=0") {
            # THIS HAS TO BE IMPROVED
            $array[$i] = "enabled=1";
        }
    }

    untie @array;

    system(package_manager() . "postfix");

}

1;