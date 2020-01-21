%Load images and correspondence points I picked

im1 = imread('DDL.jpg');
im2 = imread('Rockwell.jpg');
load('im1_pts.mat')
load('im2_pts.mat')

%% If you want to pick your own points, uncomment the code below and comment out the "load" code above:

% [im1_pts, im2_pts] = click_correspondences(im1, im2)

%%
%Define warp_frac and dissolve_frac parameters

warp_frac = linspace(0,1,60);
dissolve_frac = linspace(0,1,60);

%% Get morphed_im, which wil be a 60 X 1 cell array where every cell is a frame
%(60 total frames)

[morphed_im] = morph_tri(im1, im2, im1_pts, im2_pts, warp_frac, dissolve_frac);


%% Create gif of morhped_im

for i=1:size(morphed_im,1)
    [A,map] = rgb2ind(morphed_im{i,1},256);
    if i == 1
        imwrite(A,map,'DDL_Rockwell.gif','gif','LoopCount',Inf,'DelayTime',.1);
    else
        imwrite(A,map,'DDL_Rockwell.gif','gif','WriteMode','append','DelayTime',.1);
    end
end

