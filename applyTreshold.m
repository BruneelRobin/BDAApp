function [modifiedIm, mask] = applyTreshold (img, LColor, HColor)
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);
    
    redMask = (r <= HColor(1)) & (r >= LColor(1));
    greenMask = (g <= HColor(2)) & (g >= LColor(2));
    blueMask = (b <= HColor(3)) & (b >= LColor(3));
    
    mask = (redMask == 1) & (greenMask == 1) & (blueMask == 1);
    
    r(mask == 0) = 0;
    g(mask == 0) = 0;
    b(mask == 0) = 0;
    
    img(:,:,1) = r;
    img(:,:,2) = g;
    img(:,:,3) = b;
    
    modifiedIm = img;
end
    
    
    
    