function solVectorb = getSolutionVect(indexes, source, target, offsetX, offsetY)
%% Enter Your Code Here

[nr,nc]=size(indexes);

%Take laplacian of source image
lap = [0,-1,0;-1,4,-1;0,-1,0;];
source_lap = conv2(source,lap,'same');

%Overlay source image (with laplacian) onto target image. Set repalcement
%region of target image to zero as these pixels will be rebuilt.

overlay = zeros(size(target));
overlay(offsetY:offsetY+size(source_lap,1)-1,offsetX:offsetX+size(source_lap,2)-1) = source_lap;
idc = find(indexes~=0)
target(idc) = 0
overlayT = overlay + double(target);

[c,r]=find(indexes'>0);
solVectorb =zeros(1,size(r,1));

%Build up solVectorb (b in Ax=b). Incorporate replacement region boundary values.

for i=1:size(r,1)
    
    b = overlayT(r(i),c(i));
    
    if (r(i)+1) <= nr
        right = indexes(r(i)+1,c(i));
        if right == 0
            b = b+overlayT(r(i)+1,c(i));
        end
    end
    
    if (r(i)-1) >= 1
        left = indexes(r(i)-1,c(i));
        if left == 0
            b = b+overlayT(r(i)-1,c(i));
        end
    end
    
    if (c(i)+1) <= nc
        up = indexes(r(i),c(i)+1);
        if up == 0
            b = b+overlayT(r(i),c(i)+1);
        end
    end
    
    if (c(i)-1) >= 1
        down = indexes(r(i),c(i)-1);
        if down == 0
            b = b+overlayT(r(i),c(i)-1);
        end
    end
    
    solVectorb(1,i) = b;
    
end

solVectorb = solVectorb'

end
