Im = imread("2018_3 VWF 15 raw.tif");
imshow(Im)
gray = rgb2gray(Im);
imshow(gray)
mask = gray > 200;
gray(mask) = 0;
gray(~mask) = 255;
imshow(gray)
fillHoles = imfill(gray,'holes');
imshow(fillHoles)
figure
beter = bwareaopen(fillHoles, 1500);
imshow(beter)
figure

r = Im(:,:,1);
g = Im(:,:,2);
b = Im(:,:,3);
r(beter==0) = 255;
g(beter==0) = 255;
b(beter==0) = 255;
Im(:,:,1) = r;
Im(:,:,2) = g;
Im(:,:,3) = b;

imshow(Im)
figure

[height, width] = size(beter);
buffer = 300

[rows, columns] = find(beter);
row1 = max([min(rows) - buffer, 1]);
row2 = min([max(rows) + buffer, height]);
col1 = max([min(columns) - buffer, 1]);
col2 = min([max(columns) + buffer, width]);

croppedImage = Im(row1:row2, col1:col2,:);
imshow(croppedImage)
imwrite(croppedImage, 'edited.tif')
