function state=f16readin(in)
fieldnames={'npos' 'epos' 'alt' 'phi' 'theta' 'psi' 'vel' 'alpha' 'beta' 'p' 'q' 'r' 'nx' 'ny' 'nz' 'mach' 'qbar' 'ps' 'time'};
state=cell2struct(cell(size(fieldnames)), fieldnames, 2);
for i=1:length(fieldnames)
 state.(fieldnames{i})=in(:,i);   
end
