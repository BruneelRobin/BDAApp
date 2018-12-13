function [newThres] = transferThreshold (threshold, method)
    pixel = reshape(threshold,[1,1,length(threshold)]);
    newThres = method(pixel);
end