mess='$PUBX,40,GLL,1,0,0,0,0,0';

bin = dec2bin(mess,8);

for i=1:length(bin)-1
    check=xor(bin(i,1:end),bin(i+1,1:end));
end