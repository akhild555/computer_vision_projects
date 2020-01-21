function E = edgeLink(M, Mag, Ori)
%%  Description
%       use hysteresis to link edges
%%  Input: 
%        M = (H, W), logic matrix, output from non-max suppression
%        Mag = (H, W), double matrix, the magnitude of gradient
%    		 Ori = (H, W), double matrix, the orientation of gradient
%
%%  Output:
%        E = (H, W), logic matrix, the edge detection result.
%
%% ****YOU CODE STARTS HERE**** 

% To run edge linking on M, M cannot be a logical so must restore Mag
% values in M. Ori also needs to be updated.

M = M.*Mag;
Ori = M.*Ori;
E = zeros(size(M));

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

Mag1 = interp2(x,y,M,x_right,y_up);
Mag2 = interp2(x,y,M,x_left,y_down);
Mag_compare = (M>Mag1) & (M>Mag2);
M = M.*Mag_compare;

%Calculate the lower and upper threashold for edge linking. These values
%must change depending on the image.

M_b = ((M-min(M))*255)/(max(M)-min(M));
th_low = mean(M_b)*.66+ (std(M_b));
th_high = mean(M_b)*1.33 + (std(M_b));

E(M<th_low) = 0;
E(M>th_high) = 1;

% Loop through edge detection result by re-doing non max suppression on E
% with the lower and upper threshold. This will
% improve edge linking.

for i = 1:25
    
    [Ex,Ey] = gradient(E);
    E = sqrt(Ex.*Ex + Ey.*Ey);
    OriE = atan2(Ey,Ex);
    
    x_right = x+cos(OriE);
    x_left = x-cos(OriE);
    y_up = y-sin(OriE);
    y_down = y+sin(OriE);
    
    E1 = interp2(x,y,E,x_right,y_up);
    E2 = interp2(x,y,E,x_left,y_down);
    E_compare = (M>E1) & (M>E2);
    E = E.*E_compare;
    
    M_b = ((E-min(E))*255)/(max(E)-min(E));
    th_low = mean(M_b)*.66+ (std(M_b));
    th_high = mean(M_b)*1.33 + (std(M_b));

    E(M<th_low) = 0;
    E(M>th_high) = 1;
    
end

E = logical(E);



end