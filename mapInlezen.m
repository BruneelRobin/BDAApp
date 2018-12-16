%clear;
%clc;

function images = mapInlezen(path)
file = dir(strcat(path, '*.tif')); 
resultaat = [];
for k = 1 : length(file)
    resultaat{k} = file(k).name;
end
images = string(resultaat);
disp(images)
end 


