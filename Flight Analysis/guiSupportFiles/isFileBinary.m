function TF = isFileBinary(filename)
fid = fopen(filename,'r');

x = fread(fid,200,'char');

%  %check if there are characters outside of 32 and 127, since these are probably
%  %going to be in a binary file. If there aren't, it's probably an ASCII
%  %file. The exception is line endings (and potential null characters from GPS)
%  %so check for ASCII 10,13,and 0.
% probablyBinary = (x<32 | x>127) & (x~=10 | x~=13 | x~=0);

%probablyAscii seems more reliable than probablyBinary
probablyAscii = x==9; %if there are tabs, it's a delimited file, almost fersure
if logical(max(probablyAscii))
    TF = false;
else
    TF = true;
end
fclose(fid);