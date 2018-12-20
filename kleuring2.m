[afbeelding, klonterMask] = ruisVerwijderen('2017_48 MSB.tif');

hsvimg = rgb2hsv(afbeelding);

imshow(hsvimg);

[mIm, mask] = applyThreshold(hsvimg, [240/255, 100/255, 200/255], [1, 170/255, 250/255]);
mask = bwareaopen(mask, 10);

mask = filtermask(hsvimg, mask);

se = strel('diamond',1);
indicatorMask = imclose(mask,se);

newIm = applyMask(afbeelding, indicatorMask, 1.5);

figure
imshow(newIm);

rate = berekenRate(klonterMask, indicatorMask);