function angs = bitsToAngs(bits)

angs = zeros(size(bits));
for i=1:length(bits)
    angs(i,1) = bits(i,1)/norm(bits(i,:));
    angs(i,2) = bits(i,2)/norm(bits(i,:));
    angs(i,3) = bits(i,3)/norm(bits(i,:));
end