% File Name: cumMinEngVer.m
% Author: Akhil Devarakonda
% Date: 10/21/19

function [Mx, Tbx] = cumMinEngVer(e)
% Input:
%   e is the energy map

% Output:
%   Mx is the cumulative minimum energy map along vertical direction.
%   Tbx is the backtrack table along vertical direction.

% Write Your Code Here


Mx = zeros(size(e));
Tbx = zeros(size(e));

%First row of Mx is first row of energy map

Mx(1,:) = e(1,:);

%Pad matricies for edge cases

Mx = padarray(Mx,[1 1],nan);
e = padarray(e,[1 1],nan);
Tbx = padarray(Tbx,[1 1],nan);


nc = size(e,2);

%Loop through Mx indices to build the minimum energy map. Build the path
%matrix Tbx

for i = 3:size(e,1)-1
    for j = 2:size(e,2)-1
        
        Mx(i,j) = e(i,j)+min([Mx(i-1,j-1) Mx(i-1,j) Mx(i-1,j+1)]);
        
        [a,b] = min([Mx(i-1,j-1) Mx(i-1,j) Mx(i-1,j+1)]);
        
        if b == 1
            Tbx(i,j) = -1;
        elseif b == 2
            Tbx(i,j) = 0;
        elseif b == 3
            Tbx(i,j) = 1;
        end
        
    end
end

%Remove padding from Mx and Tbx matrices

Mx = Mx(2:end-1,2:end-1);
Tbx = Tbx(2:end-1,2:end-1);

end