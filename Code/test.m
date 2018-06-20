%n = 10; k = 32; d = 64; e = 0.4; A = rand(d,n);
function [prob, ct, O, Average_ct] = fjlt1_inequality(n,k,d,e,A)

tmp = zeros([4,n]);
tic;
[Phi,NZ] = createFJLT1projectionMatrix(k,d,n,e);
t = toc;
ct = zeros(1,n) + t;
for i = 1:n
    x = A(:,i);
    tic;
    px = Phi*x;
    ct(i) = toc;
    tmp(1,i) = (1-e)*k*norm(x,2);
    tmp(2,i) = norm(px,k);
    tmp(3,i) = (1+e)*k*norm(x,2);
    if ((tmp(2,i) >= tmp(1,i)) && (tmp(2,i) <= tmp(3,i)))
        tmp(4,i) = 1;
    else
        tmp(4,i) = 0;
    end
end

prob = sum(tmp(4,:))/n;
O = d*log(d)+NZ;
Average_ct = mean(ct);

end