open(FH, "@ARGV[0]");
$i = 0;
# ��٥롢����ޡ��հס����֤΄I��
while ($line = <FH>) {
	$line =~ s/,/ /g;
	$line =~ s/\t/ /g;
	$line =~ s/\:/ : /g;
	$line =~ s/^ +//g;
	chomp($line);
	@instruction = split(/ +/, $line);
	if (@instruction[1] eq ":") {
		$labels{@instruction[0]} = $i;
	}
	$i++;
}

close(FH);
open(FH, "@ARGV[0]");
$i = 0;
while ($line = <FH>) {
# print("$i : "); 
$line =~ s/,/ /g;
$line =~ s/\t+/ /g;
$line =~ s/\:/ : /g;
$line =~ s/^ +//g;
# print($line);
chomp($line);
@instruction = split(/ +/, $line);
if (@instruction[1] eq ":") { #��٥�Τ����Ф�ե��`��ɤ˷ָ��
	$op = @instruction[2];
	$f2 = @instruction[3];
	$f3 = @instruction[4];
	$f4 = @instruction[5];
	$f5 = @instruction[6];
} else { # ��٥�Τʤ��Ф�ե��`��ɷָ��
	$op = @instruction[0];
	$f2 = @instruction[1];
	$f3 = @instruction[2];
	$f4 = @instruction[3];
	$f5 = @instruction[4];
}
#�Cе�Z�γ���
if ($op eq "add"){
	p_b(6,0); p_r3($f2, $f3, $f4); p_b(11,0);print("\n");} 
	elsif ($op eq "addi") {p_b(6,1); p_r2i($f2, $f3); p_b(16, $f4);print("\n");}
	elsif ($op eq "sub"){p_b(6,0); p_r3($f2, $f3, $f4); p_b(11, 2); print("\n");}
	elsif ($op eq "lui") {p_b(6,3); p_r2i($f2, "r0"); p_b(16, $f3); print("\n");}
	elsif ($op eq "and"){p_b(6,0); p_r3($f2, $f3, $f4); p_b(11, 8); print("\n");}
	elsif ($op eq "andi") {p_b(6,4); p_r2i($f2, $f3); p_b(16, $f4); print("\n");}
	elsif ($op eq "or"){p_b(6,0); p_r3($f2, $f3, $f4); p_b(11,9);print("\n");}
	elsif ($op eq "ori"){p_b(6,5); p_r2i($f2, $f3); p_b(16, $f4);print("\n");}
	elsif ($op eq "xor"){p_b(6,0); p_r3($f2, $f3, $f4); p_b(11,10);print("\n");}
	elsif ($op eq "xori"){p_b(6,6); p_r2i($f2, $f3); p_b(16, $f4);print("\n");}
	elsif ($op eq "nor"){p_b(6,0); p_r3($f2, $f3, $f4); p_b(11,11);print("\n");}
	elsif ($op eq "sll"){p_b(6,0); p_r3($f2, $f3, "r0"); p_b(5, $f4); p_b(6,16);print("\n");}
	elsif ($op eq "srl"){p_b(6,0); p_r3($f2, $f3, "r0"); p_b(5, $f4); p_b(6,17);print("\n");}
	elsif ($op eq "sra"){p_b(6,0); p_r3($f2, $f3, "r0"); p_b(5, $f4); p_b(6,18);print("\n");}
	elsif ($op eq "lw"){p_b(6,16); p_r2i($f2, base($f3)); p_b(16, dpl($f4));print("\n");}
	elsif ($op eq "lh"){p_b(6,18); p_r2i($f2, base($f3)); p_b(16, dpl($f4));print("\n");}
	elsif ($op eq "lb"){p_b(6,20); p_r2i($f2, base($f3)); p_b(16, dpl($f4));print("\n");}
	elsif ($op eq "sw"){p_b(6,24); p_r2i($f2, base($f3)); p_b(16, dpl($f4));print("\n");}
	elsif ($op eq "sh"){p_b(6,26); p_r2i($f2, base($f3)); p_b(16, dpl($f4));print("\n");}
	elsif ($op eq "sb"){p_b(6,28); p_r2i($f2, base($f3)); p_b(16, dpl($f4));print("\n");}
	elsif ($op eq "beq") {p_b(6,32); p_r2b($f2, $f3); chop($f4); p_b(16, $labels{$f4}-$i-1);print("\n");}
	elsif ($op eq "bne") {p_b(6,33); p_r2b($f2, $f3); chop($f4); p_b(16, $labels{$f4}-$i-1);print("\n");}
	elsif ($op eq "blt") {p_b(6,34); p_r2b($f2, $f3); chop($f4); p_b(16, $labels{$f4}-$i-1);print("\n");}
	elsif ($op eq "ble") {p_b(6,35); p_r2b($f2, $f3); chop($f4); p_b(16, $labels{$f4}-$i-1);print("\n");}
	elsif ($op eq "j") {p_b(6,40); chop($f2); p_b(26, $labels{$f2});print("\n");}
	elsif ($op eq "jal"){p_b(6, 41); chop($f2); p_b(26, $labels{$f2});print("\n");}
	elsif ($op eq "jr"){p_b(6, 42); p_r3("r0", $f2, "r0"); p_b(11, 0);print("\n");} 
	else {print("ERROR: Illegal Instruction\n");}
	$i++;
}
close(FH);

sub p_b{#  $num��2�M��$digits�ˉ�Q���Ƴ���
	($digits, $num) = @_;
	if ($num >= 0) {
		printf("%0".$digits."b_", $num);
	} else {
		print(substr(sprintf("%b ", $num), 64-$digits));
	}
}
sub p_r3{#  R�ͤΥ쥸�������ؤ����
	($rd, $rs, $rt) = @_;
	$rs =~ s/r//; p_b(5, $rs);
	$rt =~ s/r//; p_b(5, $rt);
	$rd =~ s/r//; p_b(5, $rd);
}
sub p_r2i{#  I�ͤΥ쥸�������ؤ����	
	($rt, $rs) = @_;
	$rs =~ s/r//; p_b(5, $rs);
	$rt =~ s/r//; p_b(5, $rt);
}
sub p_r2b{# ������᪤Ǳ��^����쥸�������ؤ����
	($rs, $rt) = @_;
	$rs =~ s/r//; p_b(5, $rs);
	$rt =~ s/r//; p_b(5, $rt);
}
sub base{# �٩`�����ɥ쥹�쥸�����η��ؤ򷵤�
	($addr) = @_;
	$addr =~ s/.*\(//;
	$addr =~ s/\)//;
	return($addr); 
}
sub dpl{# ��λ�򷵤�
	($addr) = @_;
	$addr =~ s/\(.*\)//;
	return($addr); 
}