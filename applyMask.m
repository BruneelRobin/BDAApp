function [newIm] = applyMask (im, mask, multiplier)
newIm = im;
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);

r(mask) = r(mask)*0.75/multiplier;
g(mask) = g(mask)*0.75/multiplier;
b(mask) = b(mask)*1.2*multiplier;
b(b>255) = 255;

newIm(:,:,1) = r;
newIm(:,:,2) = g;
newIm(:,:,3) = b;

end