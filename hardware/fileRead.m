
copyfile('G:\DATALOG.TXT',cd);

fs(1).length = 4;fs(1).type = 'uint32';fs(1).name = 'time';
fs(1).length = 4;fs(1).type = 'uint32';fs(1).name = 'utcTime';

s=readfields('DATALOG.TXT',fs);
delete('DATALOG.TXT');

% delete('G:\DATALOG.TXT');
