#!/usr/bin/perl
use WWW::Mechanize;
use File::Basename;

#  getAPOTD.pl
#  
#  Copyright 2013 jordonr <jordonr@dev-linux>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  

$url = "http://apod.nasa.gov/apod/astropix.html"; # APOD site
$imglocation = "~/Pictures/bg/space/"; # Where you want the pictures downloaded
$backdrop = "~/.config/xfce4/desktop/backdrop.list"; # Where your xfce4 backdrop.list file is located

$mech = WWW::Mechanize->new;
$mech->get($url);

$link = $mech->find_link( url_regex => qr/jpg/ );

if(ref($link) eq 'WWW::Mechanize::Link') {
	
	$filename = basename($link->url());
	
	unless(-e $filename) {

		$mech->get($link->url_abs(), ':content_file' => $imglocation . $filename);

		open(BACKDROP, '>>'.$backdrop);

		print BACKDROP $imglocation . $filename . "\n";

		close(BACKDROP);

	}
	
}
