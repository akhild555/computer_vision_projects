% File Name: cumMinEngHor.m
% Author: Akhil Devarakonda
% Date: 10/21/19

function [My, Tby] = cumMinEngHor(e)
% Input:
%   e is the energy map.

% Output:
%   My is the cumulative minimum energy map along horizontal direction.
%   Tby is the backtrack table along horizontal direction.

% Write Your Code Here


My = zeros(size(e));
Tby = zeros(size(e));

%First column of My is first column of energy map

My(:,1) = e(:,1);

%Pad matricies for edge cases

My = padarray(My,[1 1],nan);
e = padarray(e,[1 1],nan);
Tby = padarray(Tby,[1 1],nan);

nr = size(e,1);

%Loop through My indices to build the minimum energy map. Build the path
%matrix Tby

for j = 3:size(e,2)-1
    for i = 2:size(e,1)-1
        
        My(i,j) = e(i,j)+min([My(i-1,j-1) My(i,j-1) My(i+1,j-1)]);
        
        [a,b] = min([My(i-1,j-1) My(i,j-1) My(i+1,j-1)]);
        
        if b == 1
            Tby(i,j) = -1;
        elseif b == 2
            Tby(i,j) = 0;
        elseif b == 3
            Tby(i,j) = 1;
        end
        
    end
end

%Remove padding from My and Tby matrices

My = My(2:end-1,2:end-1);
Tby = Tby(2:end-1,2:end-1);

end