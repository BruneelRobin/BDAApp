%%
Im = imread('2018_1 VWF 17.tif');

bins = 128
hsvimg = rgb2hsv(Im);
modifiedIm = applyTreshold(hsvimg, [0.5,0,0.5], [1,0.5,1]);

figure
imshow(modifiedIm)
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