% CMYK
% Tonen kanalen CMYK
% Meer afbeeldingen inladen
% Automatisch stappen doen


Im = imread("test.tif");
%imshow(Im);
Im(end-70:end-30,30:330,:) = 255;
%Im(end-70:end-30,30:330,2) = 255;
%Im(end-70:end-30,30:330,3) = 255; % watermark verwijderen
%imshow(Im);
gray = rgb2gray(Im);
%imshow(gray);
bestThreshold = getBestThreshold(gray, 200);
%if bestThreshold == 200 & max(
%    mask = gray > 240;
%    disp('Lage kleur')
%else 
mask = gray > bestThreshold;
%end

gray(mask) = 0;
gray(~mask) = 255;

%imshow(gray);

%imshow(gray);
%fillHoles = imfill(gray,'holes');
%imshow(fillHoles);
%filledHoles = ~bwareaopen(mask, 5000);
%filledHoles = fillHoles & ~gray
se = strel('disk',1);
fillHoles = imclose(gray,se);
%imshow(~gray)
fillHoles = ~bwareaopen(~gray, 1000); %holtes opvullen
%fillHoles = fillHoles & gray;
%figure
%imshow(fillHoles);
figure
beter = bwareaopen(fillHoles, 5000); % holtes verwijderen
%imshow(beter);
%hold on;B = bwboundaries(beter,'noholes');visboundaries(B);

%figure

%imshow(beter);

r = Im(:,:,1);
g = Im(:,:,2);
b = Im(:,:,3);
r(beter==0) = 255;
g(beter==0) = 255;
b(beter==0) = 255;
Im(:,:,1) = r;
Im(:,:,2) = g;
Im(:,:,3) = b;

%imshow(Im)
%figure

[height, width] = size(beter);
buffer = 300

[rows, columns] = find(beter);
row1 = max([min(rows) - buffer, 1]);
row2 = min([max(rows) + buffer, height]);
col1 = max([min(columns) - buffer, 1]);
col2 = min([max(columns) + buffer, width]);

croppedImage = Im(row1:row2, col1:col2,:);
%imshow(croppedImage)
imwrite(croppedImage, 'edited.tif','Compression','none','Resolution',100);
