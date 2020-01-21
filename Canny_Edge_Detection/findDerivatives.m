function [Mag, Magx, Magy, Ori] = findDerivatives(I_gray)
%%  Description
%       compute gradient from grayscale image 
%%  Input: 
%         I_gray = (H, W), double matrix, grayscale image matrix 
%
%%  Output:
%         Mag  = (H, W), double matrix, the magnitued of derivative%  
%         Magx = (H, W), double matrix, the magnitude of derivative in x-axis
%         Magx = (H, W), double matrix, the magnitude of derivative in y-axis
% 				Ori = (H, W), double matrix, the orientation of the derivative
%
%% ****YOU CODE STARTS HERE**** 

% Blur the image

I_gray = double(I_gray);
blur_kernel = (1/159).*[2 4 5 4 2;4 9 12 9 4;5 12 15 12 5;4 9 12 9 4;2 4 5 4 2];

dx = [1 -1];
dy = [1;-1];

%Compute Gradient, Mag, Ori

I_smooth = conv2(I_gray,blur_kernel,'same');
[Magx,Magy] = gradient(I_smooth);
Mag = sqrt(Magx.*Magx + Magy.*Magy);
Ori = atan2(Magy,Magx);

end