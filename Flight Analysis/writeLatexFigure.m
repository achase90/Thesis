function writeLatexFigure(fid,filePath,name)
% filePath = strrep(filePath,':','');
filePath = strrep(filePath,'\','/');
fprintf(fid,'\\begin{figure}[]\n');
fprintf(fid,'\t\\centering\n');
fprintf(fid,'\t\\caption{%s vs. Time}\n',name);
fprintf(fid,'\t\t\\includegraphics[width = 0.7\\textwidth]{%s/%s.eps}\n',filePath,name);
fprintf(fid,'');
fprintf(fid,'\\end{figure}\n');
% 
% \begin{figure}[h!]
%  \centering
%  \caption{press3 vs. Time} 
%    \includegraphics[width=0.5\textwidth]{figures/sampleOutput\press3.eps}
% \end{figure}