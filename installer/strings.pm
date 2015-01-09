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

package Strings;

use strict;
use warnings;
use Term::ANSIColor;


my @messages = (
    "Welcome to " . color('magenta') . "postfix-office" . color('reset') . ", tool that provides support for configuring your own e-mail server.",
    "This script is able to install everything what is needed, some components are optional.",
    "Components that will be installed and configured first are: PostgreSQL (if not available), Postfix, Dovecot and dspam. These are mandatory in current version.",
    color('red') . "Please, run as root" . color('reset'),
    color('red') . "Your system is not supported" . color('reset'),
    "Detected your distribution as " . color("yellow") . "Centos" . color("reset") . ".",
    "Detected your distribution as " . color("yellow") . "Debian" . color("reset") . ".",
    "Postfix-office is going to update your system now. Press ENTER to continue.",
    "On Centos default version of Postfix should be removed now. It must be installed from Centos Plus repository. Follow directions from your package manager. Press ENTER to start.",
);

sub get_variable {
	return $messages[$_[0]];
}

1;