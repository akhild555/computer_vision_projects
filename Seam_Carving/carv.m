% File Name: carv.m
% Author: Akhil Devarakonda
% Date: 10/24/19

function [Ic, T] = carv(I, nr, nc)
% Input:
%   I is the image being resized
%   [nr, nc] is the numbers of rows and columns to remove.
% 
% Output: 
% Ic is the resized image
% T is the transport map

% Write Your Code Here

I = imread(I);
T = zeros(nr+1,nc+1);
Ix = I;
Iy = I;

%Images is a cell of all possible combinations of horizontal and vertical
%seam removals

Images = cell(nr+1,nc+1);
Images{1,1} = I;

%Generate Path matrix to find minimum cost path for horizontal and vertical
%seam removal

Path = zeros(nr+1,nc+1);
Path(:,1) = 1;
Path(1,:) = 0;

%Build first column of Images cells. Each consecutive column entry
%represents one horizontal seam removal up to nr.

for i = 1:nr
    
    e = genEngMap(Iy);
    [My, Tby] = cumMinEngHor(e);
    [Iy, E] = rmHorSeam(Iy, My, Tby);
    Images{i+1,1} = Iy;
    T(i+1,1) = T(i,1)+ E;
    
end

%Build first row of Images cells. Each consecutive row entry
%represents one vertical seam removal up to nc.

for j = 1:nc
    e = genEngMap(Ix);
    [Mx, Tbx] = cumMinEngVer(e);
    [Ix, E] = rmVerSeam(Ix, Mx, Tbx);
    Images{1,j+1} = Ix;
    T(1,j+1) = T(1,j)+ E;

end

%Build up Images cell, Path matrix, T matrix (cost)

for k = 2:nr+1
    for m =2:nc+1
        
        %Caluclate costs of horizontal and vertical seam removal for a
        %particular seam number
        
        e1 = genEngMap(Images{k-1,m});
        [My, Tby] = cumMinEngHor(e1);
        [Iy, E_hor] = rmHorSeam(Images{k-1,m}, My, Tby);
        E_hor_cost = E_hor + T(k-1,m);
        
        e2 = genEngMap(Images{k,m-1});
        [Mx, Tbx] = cumMinEngVer(e2);
        [Ix, E_ver] = rmVerSeam(Images{k,m-1}, Mx, Tbx);
        E_ver_cost = E_ver+T(k,m-1);
        
        %Check if horizontal or vertical seam removal is lower cost for
        %that particular seam number and build up path matrix
        
        if E_ver_cost < E_hor_cost
            T(k,m) = E_ver_cost;
            Images{k,m} = Ix;
            Path(k,m) = 0;       
        else
            T(k,m) = E_hor_cost;
            Images{k,m} = Iy;
            Path(k,m) = 1;            
        end
        
    end
end

Ic = Images{end,end};

%Loop through path matrix from the end to start to find the lowest cost
%horizontal and vertical seam removal

x = nr+1;
y = nc+1;
step = 0;
while true
    
    step = step+1;
    Path_Images{step} = Images{x,y};
    
    if x==1 && y==1
        break;
    elseif Path(x,y) == 0
        y = y-1;
    else
        x = x-1;
    end
    
end

%Generate gif of horizontal and vertical seam removal

Path_Images = flip(Path_Images)';

for i=1:size(Path_Images,1)
    [A,map] = rgb2ind(Path_Images{i,1},256);
    if i == 1
        imwrite(A,map,'seam_gif.gif','gif','LoopCount',Inf,'DelayTime',.1,'DisposalMethod','restoreBG');
    else
        imwrite(A,map,'seam_gif.gif','gif','WriteMode','append','DelayTime',.1,'DisposalMethod','restoreBG');
    end
end

end

