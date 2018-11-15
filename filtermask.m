function [newMask] = filtermask(image, mask)
    hue = image(:,:,1);
    sat = image(:,:,2);
    val = image(:,:,3);
    % een unie van alle gefilterde waarden en de originele mask
    newMask = mask & filterFreq(hue, mask, 0.1) ;%& filterAvg(sat, mask, 0.5) & filterAvg(val, mask, 0.5);
end

function [newMask] = filterFreq (col, mask, freq)
    bins = 32;
    data = col(mask);
    [values, bincenters] = hist(data, bins);
    binWidth = bincenters(2)-bincenters(1);
    
    [val, ind] = sort(values,'descend');
    filterVal = val(floor(freq*bins));
    filterMask = values > filterVal;
    
    newMask = zeros(size(col));
    for center = bincenters(filterMask)
        m = (col > center - binWidth/2) & (col < center + binWidth/2);
        newMask = newMask | m;
    end
end

function [newMask] = filterAvg (col, mask, multiplier)
    bins = 32;
    data = col(mask);
    [values, bincenters] = hist(data, bins);
    binWidth = bincenters(2)-bincenters(1);
    
    filterVal = multiplier*sum(values)/bins
    filterMask = values > filterVal;
    
    newMask = zeros(size(col));
    for center = bincenters(filterMask)
        m = (col > center - binWidth/2) & (col < center + binWidth/2);
        newMask = newMask | m;
    end
end