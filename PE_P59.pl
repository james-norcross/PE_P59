#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

#open cypher text and read to array
open CTEXT, 'p059_cipher.txt' or die "Problem: $!";
my $ctext = <CTEXT>;
my @ctext = split(',',$ctext);
#create 3 digit key, loop through cypher text applying xor decoding with key
my @keys = ("a" ... "z");
my $key1;
my $key2;
my $key3;

#brute force search of all possible 3 character keys
OUTER: foreach $key1 (@keys)
{
	foreach $key2  (@keys)
	{
		foreach $key3 (@keys)
		{
			my @key = ($key1, $key2, $key3);

			my $key_index = 0;		
			my $digit;
			my $result = "";
			
			
			#decrypt byte at a time and build up unencrypted result
			foreach $digit (@ctext)
			{
				$result = $result.(chr($digit ^ ord($key[$key_index])));
				$key_index++;
				if($key_index == 3){$key_index = 0};
			}
			
			
			#assume the message is english, check for a common word
			#if find that word, print the result and calculate the sum of the ascii values of the characters
			if($result =~ / the /) 
			{
				print $result,"\n";
				my @chars = split("",$result);
				my $sum = 0;
				my $c;
				foreach $c (@chars)
				{
					$sum += ord($c);
				}
				print "The sum of all the characters in the decrypted text is $sum \n";
				last OUTER;
			}
		}	}
}



