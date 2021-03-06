#
# This file is part of App-Cme
#
# This software is Copyright (c) 2014 by Dominique Dumont.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
# ABSTRACT: Edit the configuration of an application

package App::Cme::Command::edit ;
$App::Cme::Command::edit::VERSION = '1.001';
use strict;
use warnings;
use 5.10.1;

use App::Cme -command ;

use base qw/App::Cme::Common/;

use Config::Model::ObjTreeScanner;

sub validate_args {
    my ($self, $opt, $args) = @_;
    $self->process_args($opt,$args);
}

sub opt_spec {
    my ( $class, $app ) = @_;
    return (
        [ "ui|if=s" => "user interface type. Either tk, curses, shell" ],
        [ "open-item=s" => "open a specific item of the configuration" ],
        $class->global_options,
    );
}

sub usage_desc {
  my ($self) = @_;
  my $desc = $self->SUPER::usage_desc; # "%c COMMAND %o"
  return "$desc [application] [file | ~~ ] [ -ui tk|curses|shell ] [ -open-item xxx ] ";
}

sub description {
    my ($self) = @_;
    return $self->get_documentation;
}
sub execute {
    my ($self, $opt, $args) = @_;

    my ($model, $inst, $root) = $self->init_cme($opt,$args);

    eval { require Config::Model::TkUI; };
    my $has_tk = $@ ? 0 : 1;

    eval { require Config::Model::CursesUI; };
    my $has_curses = $@ ? 0 : 1;

    my $ui_type = $opt->{ui};

    if ( not defined $ui_type ) {
        if ($has_tk) {
            $ui_type = 'tk';
        }
        elsif ($has_curses) {
            warn "You should install Config::Model::TkUI for a ", "more friendly user interface\n";
            $ui_type = 'curses';
        }
        else {
            warn "You should install Config::Model::TkUI or ",
                "Config::Model::CursesUI ",
                "for a more friendly user interface\n";
            $ui_type = 'shell';
        }
    }

    if ( $ui_type eq 'simple' ) {

        require Config::Model::SimpleUI;
        my $shell_ui = Config::Model::SimpleUI->new(
            root   => $root,
            title  => $inst->application . ' configuration',
            prompt => ' >',
        );

        # engage in user interaction
        $shell_ui->run_loop;
    }
    elsif ( $ui_type eq 'shell' ) {
        $self->run_shell_ui($root, $inst->application) ;
    }
    elsif ( $ui_type eq 'curses' ) {
        die "cannot run curses interface: ", "Config::Model::CursesUI is not installed\n"
            unless $has_curses;
        my $err_file = '/tmp/cme-error.log';

        print "In case of error, check $err_file\n";

        open( FH, "> $err_file" ) || die "Can't open $err_file: $!";
        open STDERR, ">&FH";

        my $dialog = Config::Model::CursesUI->new();

        # engage in user interaction
        $dialog->start($model);

        close FH;
    }
    elsif ( $ui_type eq 'tk' ) {
        die "cannot run Tk interface: Config::Model::TkUI is not installed\n"
            unless $has_tk;

        require Tk;
        require Tk::ErrorDialog;
        Tk->import;

        no warnings 'once';
        my $mw = MainWindow->new;
        $mw->withdraw;

        # Thanks to Jerome Quelin for the tip
        $mw->optionAdd( '*BorderWidth' => 1 );

        my $cmu = $mw->ConfigModelUI(
            -root       => $root,
        );

        if ($opt->{open_item}) {
            my $obj = $root->grab($opt->{open_item});
            $cmu->force_element_display($obj);
        }

        &MainLoop;    # Tk's
    }
    else {
        die "Unsupported user interface: $ui_type";
    }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

App::Cme::Command::edit - Edit the configuration of an application

=head1 VERSION

version 1.001

=head1 SYNOPSIS

  # edit dpkg config with GUI (requires Config::Model::Dpkg)
  cme edit dpkg 

  # force usage of simple shell like interface
  cme edit dpkg-copyright --ui shell

  # edit /etc/sshd_config (requires Config::Model::OpenSsh)
  sudo cme edit sshd

  # edit ~/.ssh/config (requires Config::Model::OpenSsh)
  cme edit ssh

  # edit a file (file name specification is mandatory here)
  cme edit multistrap my.conf

=head1 DESCRIPTION

Edit a configuration. By default, a Tk GUI will be opened If L<Config::Model::TkUI> is
installed. You can choose another user interface with the C<-ui> option:

=over

=item *

C<tk>: provides a Tk graphical interface (If L<Config::Model::TkUI> is
installed).

=item *

C<curses>: provides a curses user interface (If
L<Config::Model::CursesUI> is installed).

=item *

C<shell>: provides a shell like interface.  See L<Config::Model::TermUI>
for details.

=back

=head1 Common options

See L<cme/"Global Options">.

=head1 options

=over

=item -open-item

Open a specific item of the configuration when opening the editor

=back

=head1 SEE ALSO

L<cme>

=head1 AUTHOR

Dominique Dumont

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Dominique Dumont.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut
