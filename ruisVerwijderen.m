function [croppedImage, newMask] = ruisVerwijderen (filename)
    Im = imread(filename);
    Im(end-70:end-30,30:330,:) = 255;
    %Im(end-70:end-30,30:330,2) = 255;
    %Im(end-70:end-30,30:330,3) = 255; % watermark verwijderen
    %imshow(Im);
    gray = rgb2gray(Im);
    %imshow(gray);
    mask = gray > 200;
    gray(mask) = 0;
    gray(~mask) = 255;
    %imshow(gray);
    %fillHoles = imfill(gray,'holes');
    %imshow(fillHoles);
    %filledHoles = ~bwareaopen(mask, 5000);
    %filledHoles = fillHoles & ~gray
    se = strel('disk',4);
    fillHoles = imclose(gray,se);
    fillHoles = ~bwareaopen(~fillHoles, 1500); %holtes opvullen
    %fillHoles = fillHoles & gray;
    %figure
    %imshow(fillHoles);
    %figure
    newMask = bwareaopen(fillHoles, 1500); % holtes verwijderen
    %imshow(beter)
    %figure

    r = Im(:,:,1);
    g = Im(:,:,2);
    b = Im(:,:,3);
    r(newMask==0) = 255;
    g(newMask==0) = 255;
    b(newMask==0) = 255;
    Im(:,:,1) = r;
    Im(:,:,2) = g;
    Im(:,:,3) = b;

    %imshow(Im)
    %figure

    [height, width] = size(newMask);
    buffer = 300

    [rows, columns] = find(newMask);
    row1 = max([min(rows) - buffer, 1]);
    row2 = min([max(rows) + buffer, height]);
    col1 = max([min(columns) - buffer, 1]);
    col2 = min([max(columns) + buffer, width]);

    croppedImage = Im(row1:row2, col1:col2,:);
    %imshow(croppedImage)
    %imwrite(croppedImage, 'edited.tif','Compression','none','Resolution',100);
