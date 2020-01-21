function M = nonMaxSup(Mag, Ori)
%%  Description
%       compute the local minimal along the gradient.
%%  Input: 
%         Mag = (H, W), double matrix, the magnitude of derivative 
%         Ori = (H, W), double matrix, the orientation of derivative
%%  Output:
%         M = (H, W), logic matrix, the edge map
%
%% ****YOU CODE STARTS HERE**** 

% Use meshgrid to vectorize the code instead of looping

[nr, nc] =size(Mag);
[x,y] = meshgrid(1:nc,1:nr);


% Edge angle calculation

x_right = x+cos(Ori);
x_left = x-cos(Ori);
y_up = y-sin(Ori);
y_down = y+sin(Ori);

% Use interpolation to calculate pixel value at any given location. Need to find local maximum by comparing
% neighbor's values along the edge.

Mag1 = interp2(x,y,Mag,x_right,y_up);
Mag2 = interp2(x,y,Mag,x_left,y_down);

% Check if ground truth pixel values are greater than interpolated values

Mag_compare = (Mag>Mag1) & (Mag>Mag2);

M = zeros(nr,nc);
M(Mag_compare) = Mag(Mag_compare);
M = logical(M);

end