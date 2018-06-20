function S = createSparseMatrix(e,n,d,p,k)
%UNTITLED2 Summary of this function goes here
%e = 0.01; n=15; d=16;p=2;k=3;

if p == 1
    q = min((e^(-1)*log(n))/d,1);
else
    q = min((log(n)^2)/d,1);
end

S = normrnd(0,1/q,k,d);

for i = 1:1:k
    for j = 1:1:d
        S(i,j) = datasample([S(i,j),0],1,'Weights',[q 1-q]);
    end
end

end