#
# This file is part of App-Cme
#
# This software is Copyright (c) 2014 by Dominique Dumont.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
# ABSTRACT: List applications handled by cme

package App::Cme::Command::list ;
$App::Cme::Command::list::VERSION = '0.001';
use strict;
use warnings;
use 5.10.1;

use App::Cme -command ;
use Config::Model::Lister;

sub description {
    return << "EOD"
Show a list all applications where a model is available. This list depends on
installed Config::Model modules.
EOD

}

sub execute {
    my ($self, $opt, $args) = @_;

    my ( $categories, $appli_info, $appli_map ) = Config::Model::Lister::available_models;
    foreach my $cat ( keys %$categories ) {
        my $names = $categories->{$cat} || [];
        next unless @$names;
        print "$cat:\n  ", join( "\n  ", @$names ), "\n";
    }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

App::Cme::Command::list - List applications handled by cme

=head1 VERSION

version 0.001

=head1 SYNOPSIS

 cme list

=head1 DESCRIPTION

Show a list all applications where a model is available. This list depends on
installed Config::Model modules.

=head1 SEE ALSO

L<cme>

=head1 AUTHOR

Dominique Dumont

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Dominique Dumont.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut
