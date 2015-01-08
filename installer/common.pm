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
# This script contains common utilities used by postfix-office.
# -----------------------------------------------------------------------------

package Common;

use strict;
use warnings;

require "installer/strings.pm";


sub prompt {
    my ($query) = @_;
    print $query;
    chomp(my $answer = <STDIN>);
    return $answer;
}

sub question {
    my ($query, $recommended) = @_;
    if (defined $recommended) {
        my $answer = prompt("$query ($recommended): ");
        if (!length $answer) {
            return $recommended;
        }
        return $answer;
    }

    my $answer = prompt("$query: ");

    if (!length $answer) {
        question(@_);
    }
    return $answer;
}

sub yn_question {
    my ($query, $recommended) = @_;
    my ($yes, $no) = ('Y', 'n');
    if (defined $recommended) {
        if (lc($recommended) eq 'n') {
            $no = 'N';
            $yes = 'y';
        }
    } else {
        $recommended = 'y';
    }
    my $answer = lc(prompt("$query ($yes/$no): "));
    if (!length $answer) {
        $answer = lc($recommended);
    } else {
        if ($answer ne 'y' and $answer ne 'n') {
            yn_question(@_);
        }
    }
    if ($answer eq 'y') {
        return 1;
    } else {
        return 0;
    }
}

sub display {
    print Strings::get_variable($_[0]) . "\n";
}

sub error {
    die $_[0] . ', stopped';
}

sub warning {
    print $_[0] . "\n";
}

sub permissions_check {
    if ($> != 0) {
        error(Strings::get_variable(3));
    }
}

1;