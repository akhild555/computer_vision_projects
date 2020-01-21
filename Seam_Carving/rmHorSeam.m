% File Name: rmHorSeam.m
% Author: Akhil Devarakonda
% Date: 10/21/19

function [Iy, E] = rmHorSeam(I, My, Tby)
% Input:
%   I is the image. Note that I could be color or grayscale image.
%   My is the cumulative minimum energy map along horizontal direction.
%   Tby is the backtrack table along horizontal direction.

% Output:
%   Iy is the image removed one row.
%   E is the cost of seam removal

% Write Your Code Here

%Find min of last column of My as a starting point for horizontal seam

[M Ind] = min(My(:,end));
Iy = zeros(size(I,1)-1,size(I,2),3);

%Use the Tby path matrix to workout the lowest energy horizontal seam

for i = 1:size(My,2)-1
    
    tmp = I(:,end+1-i,:);
    tmp(Ind,:,:) = [];
    Iy(:,end+1-i,:) = tmp;
    
    if Tby(Ind,end+1-i) == -1
        Ind = Ind-1;
    elseif Tby(Ind,end+1-i) == 0
        Ind = Ind;
    elseif Tby(Ind,end+1-i) == 1
        Ind = Ind+1;
    end

end

E = M;    
Iy = uint8(Iy);

end