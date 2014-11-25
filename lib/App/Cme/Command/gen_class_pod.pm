#
# This file is part of App-Cme
#
# This software is Copyright (c) 2014 by Dominique Dumont.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
# ABSTRACT: Generates pod doc from model files

package App::Cme::Command::gen_class_pod ;
$App::Cme::Command::gen_class_pod::VERSION = '0.001';
use strict;
use warnings;
use 5.10.1;

use App::Cme -command ;
use Config::Model::Utils::GenClassPod;

sub description {
    return << "EOD"
Generate pod documentation from configuration models found in ./lib directory
EOD

}

sub execute {
    gen_class_pod;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

App::Cme::Command::gen_class_pod - Generates pod doc from model files

=head1 VERSION

version 0.001

=head1 SYNOPSIS

 cme gen-class-pod

=head1 DESCRIPTION

This command scans C<./lib/Config/Model/models>
and generate a pod documentation for each C<.pl> found there using
L<Config::Model::generate_doc|Config::Model/"generate_doc ( top_class_name , [ directory ] )">

=head1 SEE ALSO

L<cme>, L<Config::Model::Utils::GenClassPod>

=head1 AUTHOR

Dominique Dumont

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Dominique Dumont.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut
