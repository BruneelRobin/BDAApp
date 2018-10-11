function [list] = groupCounter(bwimage, groupLen)
    list = zeros(groupLen, 1);
    for idx = 1:numel(bwimage)
        element = bwimage(idx);
        
        if element > 0
            list(element, 1) = list(element, 1) + 1;
        end
    end
end