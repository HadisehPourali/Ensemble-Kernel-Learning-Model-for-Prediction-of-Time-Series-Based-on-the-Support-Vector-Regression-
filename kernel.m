%   X: data matrix, each row is one observation, each column is one feature
%   type: type of kernel, can be 'simple', 'poly', or 'gaussian'
%   para: parameter for computing the 'poly' kernel, for 'simple'
%       and 'gaussian' it will be ignored
%   K: kernel matrix

%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

function K=kernel(X,indexkernel,p1,p2)

N=size(X,1);
K=zeros(N,N);
for i=1:size(X,1)
    for j=1:size(X,2)
     K(i,j)=kernel2(indexkernel,X(i,:),X(j,:),p1,p2);
    end
end
end