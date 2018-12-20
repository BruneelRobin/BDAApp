Im = imread('2018_2 VWF 12.tif');
Im = Im;

bins = 128;
hsvimg = rgb2hsv(Im);
%figure
%imshow(hsvimg);

%[modifiedIm, mask] = applyThreshold(hsvimg, [200/255,35/255,0/255], [1,1,200/255]); % purple mask
for i=1:10
[modifiedIm, mask] = applyThreshold(hsvimg, [200/255,50/255,100/255], [1,(250-i*20)/255,200/255]); % black mask
%[modifiedIm2, mask2] = applyThreshold(Im, [0,0,0], [60,60,60]); % black mask
r = Im(:,:,1);
r(mask) = randi([125,255]);
g = Im(:,:,2);
g(mask) = randi([125,255]);
b = Im(:,:,3);
b(mask) = randi([125,255]);
Im(:,:,1) = r;
Im(:,:,2) = g;
Im(:,:,3) = b;
end

imshow(Im);
%%
%imwrite(applyMask(Im, mask, 1.5),'test.tif','Compression','none','Resolution',100);
%imwrite(hsvimg,'hsvimg.tif','Compression','none','Resolution',100);
%mask = mask1 | mask2;
%%mask = bwareaopen(mask, 10); % ruis verwijderen
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
newMask = bwareaopen(newMask, 10); % ruis verwijderen
%newMask = mask;
%imshow(newMask);
%se = strel('disk',1);

se = strel('diamond',1);
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

