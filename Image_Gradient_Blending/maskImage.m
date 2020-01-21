function mask = maskImage(Img)
%% Enter Your Code Here
figure, imshow(Img);
f = imfreehand;
mask = createMask(f);
figure; imshow(mask);

end

