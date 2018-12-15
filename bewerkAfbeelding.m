function [modifiedIm, indicatorMask] = bewerkAfbeelding (hsvimg, afbeelding, minTres, maxTres, filterImage)
    %Im = imread('edited.tif');
    %hsvimg = rgb2hsv(afbeelding);
    
    %si = size(hsvimg);
    %minTres = minTres(:,:,si(3));
    %maxTres = maxTres(:,:,si(3));
    
    if ~exist('minTres','var')
        % third parameter does not exist, so default it to something
        minTres = [200/255,50/255,100/255];
    end
    
    if ~exist('maxTres','var')
        % third parameter does not exist, so default it to something
        maxTres = [1,120/255,200/255];
    end

    %[modifiedIm, mask] = applyThreshold(hsvimg, [200/255,35/255,0/255], [1,1,200/255]); % purple mask
    [mIm, mask] = applyThreshold(hsvimg, minTres, maxTres); % black mask
    %[modifiedIm2, mask2] = applyThreshold(Im, [0,0,0], [60,60,60]); % black mask

    %imwrite(applyMask(Im, mask, 1.5),'test.tif','Compression','none','Resolution',100);
    %imwrite(hsvimg,'hsvimg.tif','Compression','none','Resolution',100);
    %mask = mask1 | mask2;
    mask = bwareaopen(mask, 10); % ruis verwijderen
    %figure
    %imshow(mask);
    %se = strel('disk',1);
    %mask = imclose(mask,se);
    %figure
    %imshow(mask);

    %newIm = applyMask(afbeelding, mask, 1.5);



    %figure
    %imshow(newIm);
    %imshow(hsv2rgb(modifiedIm));
    %imwrite(newIm,'test.tif','Compression','none','Resolution',100);
    
    % Filteren mask
    if (filterImage == true)
        mask = filtermask(hsvimg, mask);
    %newMask = mask;
        
    
    %modifiedIm = applyMask(afbeelding, indicatorMask, 2);
    end
    
    mask = bwareaopen(mask, 10); % ruis verwijderen
    %newMask = mask;
    %imshow(newMask);
    %se = strel('disk',1);

    %indicatorMask = newMask;
    se = strel('diamond',1);
    indicatorMask = imclose(mask,se);
    modifiedIm = applyMask(afbeelding, indicatorMask, 2);
    %imshow(applyMask(Im, newMask, 2));
    %imwrite(applyMask(Im, newMask, 2),'test2.tif','Compression','none','Resolution',100);