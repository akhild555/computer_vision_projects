function resultImg = reconstructImg(indexes, red, green, blue, targetImg)
%% Enter Your Code Here

red = red'
green = green'
blue = blue'
resultImg = targetImg;
[c,r]=find(indexes'>0);

%The vector b needs to be solved for all three RGB values to reconstruct
%the image

for i=1:size(r,1)
    resultImg(r(i),c(i),1)=red(1,i);
    resultImg(r(i),c(i),2)=green(1,i);
    resultImg(r(i),c(i),3)=blue(1,i);
end
end