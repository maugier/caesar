use Markov;
use Data::Dumper;


my $m = Markov->new();


$m->learn([split //, "maxime"]);
$m->learn([split //, "alexandre"]);


print Dumper($m);
$m->commit;
print Dumper($m);

