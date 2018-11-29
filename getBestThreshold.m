function [treshold] = getBestTreshold (grayIm, fromElement)
    %imhist(grayIm)
    [counts,binLocations] = imhist(grayIm);
    %figure
    %imhist(grayIm)
    %set(gca,'YScale','log');

    [m, ind] = min(counts(fromElement:end));
    treshold = binLocations(fromElement+ind-1);
