function [data] = imcolorhist(image, mask)
    %s = 1:255
    bins = 32;
    for i = 1:3
       col = image(:,:,i);
       figure
       data = col(mask);
       hist(data, bins);
       
       ylabel('Aantal pixels onder mask')
       xlabel('Kleurwaarde')
       title(strcat('Histogram van de',{' '}, num2str(i), 'e kleurwaarde'))
    end
end