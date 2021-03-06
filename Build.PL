
# This file was automatically generated by Dist::Zilla::Plugin::ModuleBuild v5.020.
use strict;
use warnings;

use Module::Build 0.34;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.34"
  },
  "configure_requires" => {
    "Module::Build" => "0.34"
  },
  "dist_abstract" => "Check or edit configuration data with Config::Model",
  "dist_author" => [
    "Dominique Dumont"
  ],
  "dist_name" => "App-Cme",
  "dist_version" => "1.001",
  "license" => "lgpl",
  "module_name" => "App::Cme",
  "recommends" => {
    "Config::Model::CursesUI" => 0,
    "Tk" => 0
  },
  "recursive_test_files" => 1,
  "requires" => {
    "App::Cmd::Setup" => 0,
    "Config::Model" => "2.063",
    "Config::Model::FuseUI" => 0,
    "Config::Model::Lister" => 0,
    "Config::Model::ObjTreeScanner" => 0,
    "Config::Model::SimpleUI" => 0,
    "Config::Model::TermUI" => 0,
    "Config::Model::Utils::GenClassPod" => 0,
    "Path::Tiny" => 0,
    "Pod::POM" => 0,
    "Scalar::Util" => 0,
    "perl" => "5.010"
  },
  "script_files" => [
    "bin/cme"
  ],
  "test_requires" => {
    "File::Path" => 0,
    "Probe::Perl" => 0,
    "Test::Command" => "0.08",
    "Test::File::Contents" => 0,
    "Test::More" => 0
  }
);


my %fallback_build_requires = (
  "File::Path" => 0,
  "Module::Build" => "0.34",
  "Probe::Perl" => 0,
  "Test::Command" => "0.08",
  "Test::File::Contents" => 0,
  "Test::More" => 0
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
