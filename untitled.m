%MASK BEPALEN
rawImage = imread('2018_1 VWF 17.tif');

gray = rgb2gray(rawImage);
bestThreshold = getBestThreshold(gray, 200);
mask = gray > bestThreshold;
gray(mask) = 0;
gray(~mask) = 255;
%se = strel('disk',4);
%fillHoles = imclose(gray,se);
fillHoles = ~bwareaopen(~gray, 1500);
finalMask = bwareaopen(fillHoles, 5000);%MASK TOEPASSEN

%app.croppedImage = app.rawImage;
r = rawImage(:,:,1);
g = rawImage(:,:,2);
b = rawImage(:,:,3);
r(finalMask==0) = 255;
g(finalMask==0) = 255;
b(finalMask==0) = 255;
rawImage(:,:,1) = r;
rawImage(:,:,2) = g;
rawImage(:,:,3) = b;

imshow(rawImage);