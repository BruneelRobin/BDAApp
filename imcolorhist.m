function [data] = imcolorhist(image, mask)
    %s = 1:255
    bins = 32;
    for i = 1:3
       col = image(:,:,i);
       figure
       data = col(mask);
       hist(data, bins);
    end
end