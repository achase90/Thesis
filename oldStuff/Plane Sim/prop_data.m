function [J,CT,CP,eta,data_out]=prop_data(prop,diam,pitch)
current=cd('APC');

data_files=dir([prop,'_',num2str(diam),'x',num2str(pitch),'*.txt']);
if isempty(data_files)
    error('No data files match the desired propeller. Check the function inputs, and whether the propeller is available.')
elseif length(data_files)==1
    display('Only 1 file')
    Propeller_Data=importdata(data_files(1).name,' ',1);
else
    for i=1:length(data_files)
        %         Propeller_Data(i).rpm=0;
        Propeller_Data(i)=importdata(data_files(i).name,' ',1);
        rpm_loc=strfind(data_files(i).name,'.txt');
        %todo: update the Propeller_Data stucture to include the RPM the
        %test was run at
        
        %         Propeller_Data(i).rpm=str2num(data_files(i).name(rpm_loc-4:rpm_loc-1))
    end
end

J=0;
CT=0;
CP=0;
eta=0;

% Originally concatenate all data runs into a single run. Possibly
% problems,so remove for now

for i=1:length(data_files)
%     M(i)=[Propeller_Data(1,i).data(:,1);Propeller_Data(1,i).data(:,2);Propeller_Data(1,i).data(:,3);Propeller_Data(1,i).data(:,4)];
    J=[J;Propeller_Data(1,i).data(:,1)];
    CT=[CT;Propeller_Data(1,i).data(:,2)];
    CP=[CP;Propeller_Data(1,i).data(:,3)];
    eta=[eta;Propeller_Data(1,i).data(:,4)];
end

% Possibly problem with the polyfit, so for now just use last data set
% J=Propeller_Data(1,end).data(:,1);
% CT=Propeller_Data(1,end).data(:,2);
% CP=Propeller_Data(1,end).data(:,3);
% eta=Propeller_Data(1,end).data(:,4);

data_out=[J,CT,CP,eta]; %output matrix


data_out=data_out(2:length(data_out),:);
data_out=sortrows(data_out);
J=data_out(:,1);
CT=data_out(:,2);
CP=data_out(:,3);
eta=data_out(:,4);
% Propeller_Data(:).prop=[prop,'_',num2str(diam),'_',num2str(pitch)];
cd(current);