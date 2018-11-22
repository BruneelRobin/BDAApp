function [newMask] = filtermask(image, mask)
    hue = image(:,:,1);
    sat = image(:,:,2);
    val = image(:,:,3);
    
    newMask = (mask & filter2eAfg(hue, mask, 0) & filter2eAfg(sat, mask, 0) & filter2eAfg(val, mask, 0)) | val < 0.5;
    % een unie van alle gefilterde waarden en de originele mask
    %newMask = mask & filterFreq(hue, mask, 0.1) ;%& filterAvg(sat, mask, 0.5) & filterAvg(val, mask, 0.5);
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

function [newMask] = filterAfg (col, mask)
    bins = 32;
    data = col(mask);
    [values, bincenters] = hist(data, bins);
    binWidth = bincenters(2)-bincenters(1);
    
    values = smooth(values);
    afg = values(2:length(values))-values(1:(length(values)-1));
    afg = smooth(afg);
    %afg2 = afg(2:length(afg))-afg(1:(length(afg)-1));
    
    %f=fit(1:length(values),values,'poly2')
    figure
    plot(1:length(values), values);
    figure
    plot(1:length(afg), afg);
    
    [maxVal,indexMax] = max(afg);
    [minVal,indexMin] = min(afg);
    
    bincenters(indexMax)-0.5*binWidth
    bincenters(indexMin)+0.5*binWidth
    
    newMask = (col > bincenters(indexMax)-0.5*binWidth) & (col < bincenters(indexMin)+0.5*binWidth);
end

function [newMask] = filter2eAfg (col, mask, shrink)
    bins = 32;
    data = col(mask);
    [values, bincenters] = hist(data, bins);
    binWidth = bincenters(2)-bincenters(1);
    
    values = smooth(values);
    afg = values(2:length(values))-values(1:(length(values)-1));
    afg = smooth(afg);
    afg2 = afg(2:length(afg))-afg(1:(length(afg)-1));
    
    %f=fit(1:length(values),values,'poly2')
    
    % We splitsen afg2 op in 2 delen
    [minVal,indexMin] = min(afg2);
    
    [maxVal1,indexMax1] = max(afg2(1:indexMin));
    [maxVal2,indexMax2] = max(afg2(indexMin:end));
    indexMax2 = indexMax2 + indexMin - 1;
    
    diff = bincenters(indexMax2)-bincenters(indexMax1);
    
    newMask = (col > bincenters(indexMax1)-0.5*binWidth + diff*shrink/2) & (col < bincenters(indexMax2)+0.5*binWidth - diff*shrink/2);
end
