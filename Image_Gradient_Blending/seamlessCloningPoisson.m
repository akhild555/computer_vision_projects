function resultImg = seamlessCloningPoisson(sourceImg, targetImg, mask, offsetX, offsetY)
%% Enter Your Code Here

%Get indices and coeffA matrix
mask = mask(:,:,1);
sourceImg = imread(sourceImg);
targetImg = imread(targetImg);
[targetH, targetW] = size(targetImg);
indexes = getIndexes(mask, targetH, targetW, offsetX, offsetY);
coeffA = getCoefficientMatrix(indexes);

%Get b vector for all three RGB values
red = getSolutionVect(indexes, sourceImg(:,:,1), targetImg(:,:,1), offsetX, offsetY);
green = getSolutionVect(indexes, sourceImg(:,:,2), targetImg(:,:,2), offsetX, offsetY);
blue = getSolutionVect(indexes, sourceImg(:,:,3), targetImg(:,:,3), offsetX, offsetY);


%Compute b = A\x
f_r = mldivide(coeffA,red);
f_g = mldivide(coeffA,green);
f_b = mldivide(coeffA,blue);

%clip RGB values
f_r(f_r>255) = 255;
f_r(f_r<0) = 0;
f_g(f_g>255) = 255;
f_g(f_g<0) = 0;
f_b(f_b>255) = 255;
f_b(f_b<0) = 0;

%round RGB values
f_r = round(f_r);
f_g = round(f_g);
f_b = round(f_b);

resultImg = reconstructImg(indexes, f_r, f_g, f_b, targetImg);
imshow(resultImg)

end