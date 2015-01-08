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


my @messages = (
    "Welcome to postfix-office, tool that provides support for configuring own e-mail server.",
    "This script is able to install everything what is needed, but there's a chance you'll want to set some options on your own.",
    "Choose components to be installed and configured.",
    "Please, run as root",
    "Can't detect your system",
);

sub get_variable {
	return $messages[$_[0]];
}

1;