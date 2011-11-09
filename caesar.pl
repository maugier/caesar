#!/usr/bin/perl

use Curses;
use Caesar;

my $caesar = new Caesar;

my $win = new Curses($LINES,$COLS,0,0);
my @buffer;

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

sub draw {
    
    $win->clear;
    $win->border(0,0,0,0,0,0,0,0);
    addmstr(2,($COLS-30)/2,$banner);

    if (@buffer) {
        my $c = 10;
        my $str = join '', @buffer;
        for ($caesar->break($str)) {
            $win->addstr($c++, 5, $_->[1]);
        }
    }

    $win->refresh;

}



while(1) {

	my $key = $win->getch;
    if ($key =~ /[a-z ]/) {
        push @buffer, $key;
    } elsif ($key == KEY_BACKSPACE) {
        pop @buffer;
    } elsif ($key == KEY_ENTER) {
        last;
    }

    draw();

}

endwin;
