Im = imread('edited.tif');

bins = 128;
hsvimg = rgb2hsv(Im);
%figure
%imshow(hsvimg);

%[modifiedIm, mask] = applyThreshold(hsvimg, [200/255,35/255,0/255], [1,1,200/255]); % purple mask
[modifiedIm, mask] = applyThreshold(hsvimg, [200/255,80/255,100/255], [1,120/255,140/255]); % black mask
%[modifiedIm2, mask2] = applyThreshold(Im, [0,0,0], [60,60,60]); % black mask
imwrite(applyMask(Im, mask, 1.5),'test.tif','Compression','none','Resolution',100);
%%
%mask = mask1 | mask2;
mask = bwareaopen(mask, 50); % ruis verwijderen
%figure
%imshow(mask);
%se = strel('disk',1);
%mask = imclose(mask,se);
%figure
%imshow(mask);

newIm = applyMask(Im, mask, 1.5);



%figure
%imshow(newIm);
%imshow(hsv2rgb(modifiedIm));
imwrite(newIm,'test.tif','Compression','none','Resolution',100);
%% Filteren mask
newMask = filtermask(hsvimg, mask);
%newMask = mask;
newMask = bwareaopen(newMask, 50); % ruis verwijderen
%imshow(newMask);
se = strel('disk',1);
newMask = imclose(newMask,se);

imshow(applyMask(Im, newMask, 2));
imwrite(applyMask(Im, newMask, 2),'test2.tif','Compression','none','Resolution',100);
%% Tellen pixels
total = sum(beter,'all');
ind = sum(newMask,'all');

rate = ind/total*100;

% 1 -> 13.5%
% 2 -> 11.9%
% 3 -> 22.4%
% 4 -> 56.1%

%%

modifiedIm = applyThreshold(labimg, [], []);

figure
imshow(hsv2rgb(modifiedIm));

%%
mask = (modifiedIm(:,:,1) > 0) | (modifiedIm(:,:,2) > 0) | (modifiedIm(:,:,3) > 0);

stretched = stretchColoursWithMask(modifiedIm, mask);
figure
imshow(stretched);


%figure
%decor_Im = decorrstretch(Im, 'Tol', 0.01);
%imshow(decor_Im)
%%
imshow(Im(:,:,1))
%imhist(Im(:,:,1), bins)
%set(gca,'YScale','log');
figure
imshow(Im(:,:,2))
%imhist(Im(:,:,2), bins)
%set(gca,'YScale','log');
figure
imshow(Im(:,:,3))
%imhist(Im(:,:,3), bins)
%set(gca,'YScale','log');

%gray = rgb2gray(Im);
%imshow(Im)
%%
treshold = getBestTreshold(gray, 200);
disp(treshold)

%%
mask = gray > treshold;

gray(mask) = 0;
gray(~mask) = 255;

gray = imfill(gray,'holes'); % holtes opvullen
%%
%[grid,groupLength] = bwlabel(gray);

%counts = groupCounter(grid, groupLength);
%%
[m, ind] = max(counts);
%%
mask = grid == ind;
imshow(mask);

%%
Im = imread('bloodclot.jpg');
stretched_Im = imadjust(Im, stretchlim(Im)); % contrast stretch
imshow(stretched_Im);

%%
rgb = imread('bloodclot.jpg');
[im,map] = rgb2ind(rgb,4);
imshow(im,map);

%%
Im = imread('bloodclot.jpg');
decor_Im = decorrstretch(Im, 'Tol', 0.01);
imshow(decor_Im);

%%

% actuele code
Im = imread('bloodclot.jpg');

gray = rgb2gray(Im);

mask = gray > 150;

gray(mask) = 0;
gray(~mask) = 255;

gray = imfill(gray,'holes'); % holtes opvullen

[Grid,Length] = bwlabel(gray);

count_pixels_per_obj = sum(bsxfun(@eq,Grid(:),1:Length));
[count,val] = max(count_pixels_per_obj);

biggest_clot = (Grid==val);
biggest_clot = uint8(biggest_clot);

m = cat(3, biggest_clot, biggest_clot, biggest_clot);
modifiedIm = Im.* cat(3, biggest_clot, biggest_clot, biggest_clot);

C = imfuse(Im,biggest_clot,'blend','Scaling','joint');
imshow(C);


%%
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'b', 'LineWidth', 2)
end


%%
imshow(decor_Im(:,:,1))
figure
imshow(decor_Im(:,:,2))
figure
imshow(decor_Im(:,:,3))