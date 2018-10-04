%%
Im = imread('bloodclot.jpg')
stretched_Im = imadjust(Im, stretchlim(Im)) % contrast stretch
imshow(stretched_Im)

%%
rgb = imread('bloodclot.jpg')
[im,map] = rgb2ind(rgb,4);
imshow(im,map)

%%
Im = imread('bloodclot.jpg')
decor_Im = decorrstretch(Im, 'Tol', 0.01);
imshow(decor_Im)

%%

% actuele code
Im = imread('bloodclot.jpg')

gray = rgb2gray(Im);

mask = gray > 150

gray(mask) = 0
gray(~mask) = 255

gray = imfill(gray,'holes') % holtes opvullen

[Grid,Length] = bwlabel(gray);

count_pixels_per_obj = sum(bsxfun(@eq,Grid(:),1:Length));
[count,val] = max(count_pixels_per_obj);

biggest_clot = (Grid==val);
biggest_clot = uint8(biggest_clot)

m = cat(3, biggest_clot, biggest_clot, biggest_clot)
modifiedIm = Im.* cat(3, biggest_clot, biggest_clot, biggest_clot)

C = imfuse(Im,biggest_clot,'blend','Scaling','joint');
imshow(C)


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