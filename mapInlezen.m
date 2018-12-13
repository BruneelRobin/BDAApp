%clear;
%clc;

function images = mapInlezen()

file = dir('C:\Users\Marthe\Documents\P&O\2de jaar\foto\*.tif'); 
resultaat = [];
for k = 1 : length(file)
    resultaat{k} = file(k).name;
end
images = string(resultaat); 
end 


