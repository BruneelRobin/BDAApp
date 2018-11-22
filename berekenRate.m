function [rate] = berekenRate(mask, indicatorMask)
    total = sum(mask,'all');
    ind = sum(indicatorMask,'all');

    rate = ind/total*100;