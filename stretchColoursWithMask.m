function [image] = stretchColoursWithMask (image, mask)
    for i = 1:3
        col = image(:,:,i);
        minimum = min(col(mask))
        maximum = max(col(mask))
        diff = maximum - minimum;

        col = (col-minimum)/diff;
        
        image(:,:,i) = col;
    end
end