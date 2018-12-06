%im = imread('2018_1 VWF 17.tif');
function [cmyk] = rgb2cmyk(im)
    mask = ~(rgb2gray(im) == 255);

    r = im(:,:,1);
    g = im(:,:,2);
    b = im(:,:,3);

    masked = [r(mask), g(mask), b(mask)];

    I_rgb = lin2rgb(masked); % omzetten naar SRGB
    C = makecform('srgb2cmyk');
    I_cmyk = applycform(I_rgb,C);

    % Convert back to image
    si = size(im);
    c = uint8(zeros(si(1),si(2),1));
    c(mask) = I_cmyk(:,1);
    %c(~mask) = 0;

    m = uint8(zeros(si(1),si(2),1));
    m(mask) = I_cmyk(:,2);
    m(~mask) = 0;

    y = uint8(zeros(si(1),si(2),1));
    y(mask) = I_cmyk(:,3);
    y(~mask) = 0;

    k = uint8(zeros(si(1),si(2),1));
    k(mask) = I_cmyk(:,4);
    %k(~mask) = 0;
    
    cmyk = cat(3,c,m,y,k);

    %%
    %I_rgb = lin2rgb(im);
    %C = makecform('srgb2cmyk'); 
    %I_cmyk = applycform(I_rgb,C);