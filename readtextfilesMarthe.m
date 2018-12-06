function [Data] = readtextfiles()
% Debug lines
filename = 'C:\Users\Marthe\Documents\P&O\2de jaar\foto';
firstFile = 1; 
lastFile = 3; 
columns = 21; 


% Read the data in the files
for i = firstFile:lastFile 
fid = fopen([filename num2str(i) '.txt']);
Data(i).twiss = fscanf(fid, '%g %g %g', [columns inf]);
fclose(fid);
end 
disp('Read the data in the files');

end