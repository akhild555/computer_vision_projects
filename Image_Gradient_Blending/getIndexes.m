function indexes = getIndexes(mask, targetH, targetW, offsetX, offsetY)
%% Enter Your Code Here

indexes = zeros(targetH, targetW);

%find col and row locations of non-zero elements in mask to figure out
%locations of replacement region. Img_offset will offset the replacement
%region in the target image. Make sure the mask does not escape the bounds
%of the target image.

[c, r] = find(mask'); 
img_offset_Y = r+offsetY;
img_offset_X = c+offsetX;
img_offset_Y(img_offset_Y > targetH);
img_offset_X(img_offset_X > targetW);

%Create the matrix representing the indices of each replacement pixel
indices = sub2ind(size(indexes), img_offset_Y, img_offset_X);
indexes(indices) = 1:size(indices,1);

end