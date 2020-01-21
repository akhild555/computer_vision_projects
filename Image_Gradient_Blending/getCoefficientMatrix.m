function coeffA = getCoefficientMatrix(indexes)
%% Enter Your Code Here.

%Create sparse matrix CoeffA (Laplacian) wth 4's in the diagonal

max_ind = max(max(indexes));

%Create sparse matrix and poppulate its diagonals with 4 (laplacian operation is
%being converted to matrix form)
coeffA = sparse(4*eye(max_ind));
[nr, nc] = size(indexes);
idc = find(indexes);

%Locate indices of -1 part of laplacian
left_ind = idc-nr;
up_ind = idc-1;
down_ind = idc+1;
right_ind = idc+nr;

nq1 = left_ind > 0 & left_ind < nr*nc & indexes(left_ind) ~= 0; 
nq2 = up_ind > 0 & up_ind < nr*nc & indexes(up_ind) ~= 0;
nq3 = down_ind > 0 & down_ind < nr*nc & indexes(down_ind) ~= 0;
nq4 = right_ind > 0 & right_ind < nr*nc & indexes(right_ind) ~= 0;

%Map -1 part of laplacian into the sparse coeffA matrix

coeffA((indexes(left_ind(nq1))-1)*max_ind + indexes(idc(nq1))) = -1;
coeffA((indexes(up_ind(nq2))-1)*max_ind + indexes(idc(nq2))) = -1;
coeffA((indexes(down_ind(nq3))-1)*max_ind + indexes(idc(nq3))) = -1;
coeffA((indexes(right_ind(nq4))-1)*max_ind + indexes(idc(nq4))) = -1;

end
