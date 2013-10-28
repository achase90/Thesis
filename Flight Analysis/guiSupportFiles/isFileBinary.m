function TF = isFileBinary(filename)
fid = fopen(filename,'r');

x = fread(fid,200,'char');

 %check if there are characters outside of 32 and 127, since these are probably
 %going to be in a binary file. If there aren't, it's probably an ASCII
 %file. The exception is line endings, so check for ASCII 10 and 13.
probablyBinary = x<32 | x>127 | x~=10 | x~=13;

if logical(max(probablyBinary))
    TF = true;
end
fclose(fid);