#!/usr/bin/perl
use strict;
use warnings;
use XML::LibXML;
use File::Basename;
use JSON;
use CGI;
use CGI::Carp;
use HTML::Entities;

binmode STDOUT, ":utf8";
my $debug = 1;

my $cgi = CGI->new();
my $fh = $cgi->upload("file");
binmode $fh, ":utf8";

my $parser = XML::LibXML->new();
my $response = {};

my $record = '';
while(<$fh>) {
  $record .= $_;
  if( grep /<\/rdf:RDF>/, $_ ) {
    warn 'got a record';
    my $doc = $parser->parse_string($record);
    my $root = $doc->getDocumentElement();
    my $xpc = XML::LibXML::XPathContext->new($root);
    $xpc->registerNs('dc', "http://purl.org/dc/elements/1.1/");
    $xpc->registerNs('rdf', "http://www.w3.org/1999/02/22-rdf-syntax-ns#");
    my $title = encode($xpc->findvalue('//dc:title'));
    my $creator = encode($xpc->findvalue('//dc:creator'));
    my $description = encode($xpc->findvalue('//dc:description'));
    my $subject = encode($xpc->findvalue('dc:subject'));
    my $date = encode($xpc->findvalue('dc:date'));
    my $identifier = encode($xpc->findvalue('dc:identifier'));
    push @{$response->{'records'}}, {
                                     title=>$title,
                                     author=>$creator,
                                     publisher=>$creator,
                                     date=>$date,
                                     status=>'uploaded',
                                     medium=>'blog post',
                                     Savefiles_id => 4, #uploads folder
                                     SearchTargets_id => '',
                                     xml => encode($record),
                                     xmlformat => 'xml',
                                     marcformat => '',
                                     marcflavour => '',
                                     template => '',
                                    };
    $record = '';
  }
}
$response->{'success'} = 'true';
print $cgi->header(-type=>'text/html; charset=utf8');
print to_json($response);

sub encode {
  my $str = shift;
  $str =~ s/"/|quot|/g;
  $str = encode_entities($str);
  $str =~ s/\|quot\|/\"/g;
  return $str;
}
