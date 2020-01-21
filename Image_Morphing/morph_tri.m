function [morphed_im] = morph_tri(im1, im2, im1_pts, im2_pts, warp_frac, dissolve_frac)
%MORPH_TRI Image morphing via Triangulation
%	Input im1: target image
%	Input im2: source image
%	Input im1_pts: correspondences coordiantes in the target image
%	Input im2_pts: correspondences coordiantes in the source image
%	Input warp_frac: a vector contains warping parameters
%	Input dissolve_frac: a vector contains cross dissolve parameters
% 
%	Output morphed_im: a set of morphed images obtained from different warp and dissolve parameters

% Helpful functions: delaunay, tsearchn

[X,Y] = meshgrid(1:size(im1,2),1:size(im1,1));

%Average the images and do delaunay triangulation
avg_img = (im1_pts+im2_pts)./2;
DH = delaunay(avg_img);

% Calculate a,b,c triangle coordinates in the source and target image

for j = 1:size(DH,1)

    source{j,1} = [im1_pts(DH(j,1), 1), im1_pts(DH(j,2), 1), im1_pts(DH(j,3), 1);...
                     im1_pts(DH(j,1), 2), im1_pts(DH(j,2), 2), im1_pts(DH(j,3), 2);...
                     1,1,1];
    target{j,1} = [im2_pts(DH(j,1), 1), im2_pts(DH(j,2), 1), im2_pts(DH(j,3), 1);...
                     im2_pts(DH(j,1), 2), im2_pts(DH(j,2), 2), im2_pts(DH(j,3), 2);
                     1,1,1];
end


for i=1:60
    
    cont_avg{i,1} = (1-warp_frac(i))*im1_pts+warp_frac(i)*im2_pts;
    
    %Calculate triangle number and barycentric coordinates
    
    [tri_num{i,1},bary_c{i,1}] = tsearchn(cont_avg{i,1},DH,[X(:) Y(:)]);
    
    %Tri_num and bary_c will have NaN values since some of the pixels in
    %the images will not belong to any triangle. Remove these along with their indices.
    
    remove_nan{i,1} = ~isnan(tri_num{i,1});
    tri_num{i,1} = tri_num{i,1}(remove_nan{i,1});
    bary_c{i,1} = bary_c{i,1}(remove_nan{i,1},:);
    X_img{i,1} = X(remove_nan{i,1});
    Y_img{i,1} = Y(remove_nan{i,1});
    
    %Compute new pixel positions. Round pixel location.

    for k = 1:size(X_img{i,1},1)
        
        new_source{i,1}(k,:) = source{tri_num{i,1}(k),1}*bary_c{i,1}(k,:)';
        new_source{i,1}(k,:) = (new_source{i,1}(k,:))/(new_source{i,1}(k,3));
        im1_new{i,1} = im1(round(new_source{i,1}(k,2)), round(new_source{i,1}(k,1)),:);

        new_target{i,1}(k,:) = target{tri_num{i,1}(k),1}*bary_c{i,1}(k,:)';
        new_target{i,1}(k,:) = (new_target{i,1}(k,:))/(new_target{i,1}(k,3));
        im2_new{i,1} = im2(round(new_target{i,1}(k,2)), round(new_target{i,1}(k,1)),:);

        %Morph images back together according to the dissolve_frac
        %parameter
        
        morphed_im{i,1}(Y_img{i,1}(k),X_img{i,1}(k),:) = (1-dissolve_frac(i))*im1_new{i,1} + dissolve_frac(i)*im2_new{i,1};
        
    end
    
end

end

