function [treshold] = getBestTreshold (grayIm, fromElement)
    [counts,binLocations] = imhist(grayIm);
    %set(gca,'YScale','log');

    [m, ind] = min(counts(fromElement:end));
    treshold = binLocations(fromElement+ind-1);
