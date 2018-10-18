function [] = imcolorplot(image)
    for i = 1:3
        figure
        imshow(image(:,:,i));
    end
end