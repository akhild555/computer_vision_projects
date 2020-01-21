% File Name: rmVerSeam.m
% Author: Akhil Devarakonda
% Date: 10/21/19

function [Ix, E] = rmVerSeam(I, Mx, Tbx)
% Input:
%   I is the image. Note that I could be color or grayscale image.
%   Mx is the cumulative minimum energy map along vertical direction.
%   Tbx is the backtrack table along vertical direction.

% Output:
%   Ix is the image removed one column.
%   E is the cost of seam removal

% Write Your Code Here

%Find min of last row of Mx as a starting point for vertical seam

[M Ind] = min(Mx(end,:));
Ix = zeros(size(I,1),size(I,2)-1,3);

%Use the Tbx path matrix to workout the lowest energy vertical seam

for i = 1:size(Mx,1)-1
    
    tmp = I(end+1-i,:,:);
    tmp(:,Ind,:) = [];
    Ix(end+1-i,:,:) = tmp;
    
    if Tbx(end+1-i,Ind) == -1
        Ind = Ind-1;
    elseif Tbx(end+1-i,Ind) == 0
        Ind = Ind;
    elseif Tbx(end+1-i,Ind) == 1
        Ind = Ind+1;
    end
    
end

E = M;    
Ix = uint8(Ix);

end
