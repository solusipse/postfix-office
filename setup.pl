#!/usr/bin/perl

use strict;
use warnings;

require "installer/common.pm";
require "installer/install.pm";


Common::permissions_check();

Common::print_spacer();
Common::display(0);
Common::display(1);
Common::display(2);
Common::print_spacer();

Install::detect_info();

Common::display(7);
<STDIN>;
Install::update_system();


Common::print_spacer();