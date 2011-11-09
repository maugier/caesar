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
#halfdelay(5);
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

sub box {
        my ($y, $x, $h, $w, $title) = @_;
        $win->addch($y-1,$x-1,'+');
        $win->addch($y+$h,$x+$w,'+');
        $win->addch($y-1,$x+$w,'+');
        $win->addch($y+$h,$x-1,'+');
        $win->addch($y-1,$_,'-') for $x .. ($x + $w - 1);
        $win->addch($y+$h,$_,'-') for $x .. ($x + $w - 1);
        $win->addch($_,$x-1, '|') for $y .. ($y + $h - 1);
        $win->addch($_,$x+$w,'|') for $y .. ($y + $h - 1);
        $win->addstr($y-1, $x, $title);
}

sub draw {
    
    $win->clear;
    $win->border(0,0,0,0,0,0,0,0);
    addmstr(2,($COLS-30)/2,$banner);

    box(10,5,1,$COLS-10, "original");
    $win->addstr(10,5, (join '', @buffer));

    box(14,5,26,$COLS-10, "clef+probabilité");


    if (@buffer) {
        my $c = 14;
        my $str = join '', @buffer;
        for ($caesar->break($str)) {
            my $out = sprintf " %02d | % 8f | %s", $_->[0], $_->[2][1], $_->[1];
            $win->addstr($c++, 5, $out);
        }
    }

    $win->refresh;

}



while(1) {

    draw();

	my $key = $win->getch;
    if ($key =~ /[a-z ]/) {
        push @buffer, $key;
    } elsif ($key eq KEY_BACKSPACE || $key eq KEY_DELETE) {
        pop @buffer;
    } elsif ($key eq KEY_ENTER) {
        last;
    }


}

endwin;
