package Tie::Hash::Log;

# DATE
# VERSION

use strict;
use warnings;
use Log::ger;

sub TIEHASH {
    my $class = shift;

    my $ref = {@_};
    log_trace "TIEHASH(%s, %s)", $class, $ref;
    bless $ref, $class;
}

sub FETCH {
    my ($this, $key) = @_;
    my $res = $this->{$key};
    log_trace "FETCH(%s) = %s", $key, $res;
    $res;
}

sub STORE {
    my ($this, $key, $value) = @_;
    log_trace "STORE(%s, %s)", $key, $value;
    $this->{$key} = $value;
}

sub DELETE {
    my ($this, $key) = @_;
    log_trace "DELETE(%s)", $key;
    delete $this->{$key};
}

sub CLEAR {
    my ($this) = @_;
    log_trace "CLEAR()";
    %{$this} = ();
}

sub EXISTS {
    my ($this, $key) = @_;
    my $res = exists $this->{$key};
    log_trace "EXISTS(%s): %s", $key, $res;
    $res;
}

sub FIRSTKEY {
    my ($this) = @_;
    my $dummy = keys %{$this}; # reset iterator
    my $res = each %$this;
    log_trace "FIRSTKEY(%s): %s", $key, $res;
    $res;
}

sub NEXTKEY {
    my ($this, $lastkey) = @_;
    my $res = each %$this;
    log_trace "NEXTKEY(%s): %s", $lastkey, $res;
    $res;
}

sub SCALAR {
    my ($this, $lastkey) = @_;
    my $res = keys %$this;
    log_trace "SCALAR(): %s", $res;
    $res;
}

sub UNTIE {
    my ($this) = @_;
    log_trace "UNTIE()";
}

# DESTROY

1;
# ABSTRACT: Tied hash that behaves like a regular hash, but logs operations

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 use Tie::Hash::Log;

 tie my %hash, 'Tie::Hash::Log';

 # use like you would a regular hash
 $hash{one} = 'value';
 ...


=head1 DESCRIPTION

This class implements tie interface for hash but performs regular hash
operations, except logging the operation with L<Log::ger>. It's basically used
for testing or benchmarking.


=head1 SEE ALSO

L<perltie>

L<Log::ger>

=cut
