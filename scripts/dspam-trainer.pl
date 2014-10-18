#!/usr/bin/perl

# -----------------------------------------------------------------------------
# This script was made to automate DSPAM training routines.
# Script works for following structure: /path/to/vmail/<domain>/<user>
# -----------------------------------------------------------------------------

use warnings;
use strict;

use File::Basename;

# Configuration
# -----------------------------------------------------------------------------
# Do edit below this line
# -----------------------------------------------------------------------------

# If you will not provide these informations, script will ask for them
# on startup.

# e.g. "/home/vmail"
our $vmail_directory = "";

# e.g. ".Junk"
our $spam_folder = "";

# syntax: command <username> <path_to_mailbox><spam_folder>/ <path_to_mailbox>cur/
our $dspam_command = "dspam_train %s %s%s/cur/ %scur/";

# End of configuration section
# -----------------------------------------------------------------------------
# Do not edit below this line
# -----------------------------------------------------------------------------


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

sub check_config {
    if (!length $vmail_directory) {
        $vmail_directory = question("Path to vmail directory", "/home/vmail");
    }
    if (!length $spam_folder) {
        $spam_folder = question("Name of spam folder", ".Junk");
    }
}

sub get_account_paths {
    return <"$vmail_directory/*/*/">;
}

sub get_account_name {
    return basename($_)
}

sub main {
    foreach (get_account_paths) {
        my $command = sprintf($dspam_command, get_account_name($_), $_, $spam_folder, $_) . "\n";
        print $command . "\n";
        system($command);
    }
}

check_config;
main;

