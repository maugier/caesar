#!/usr/bin/perl

use Curses;

my $win = new Curses($LINES,$COLS,0,0);

sub addmstr {
        my ($y, $x, $text) = @_;
        for (split /\n/,$text) {
                chomp;
                $win->addstr($y,$x,$_);
                $y++;
        }
}


cbreak();
halfdelay(5);
noecho();
nonl();
curs_set(0);

my $banner = <<EOF
    ___ __ _  ___  ___  __ _ _ __ 
   / __/ _` |/ _ \\/ __|/ _` | '__|
  | (_| (_| |  __/\\__ \\ (_| | |   
   \\___\\__,_|\\___||___/\\__,_|_|   

EOF
;

$win->border(0,0,0,0,0,0,0,0);
addmstr(2,($COLS-30)/2,$banner);

$win->refresh;

while(1) {

	my $key = $win->getch;
	last if $key eq 'q';
	$win->refresh;

}

endwin;
