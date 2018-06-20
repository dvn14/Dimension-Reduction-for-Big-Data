function [Phi,prob,Average_ct,Max_ct] = fjlt2_prep(n,k,d,beta,A,e)
    %clear; n = 50; k = 4; d = 64; beta = 8; A = normc(rand(d,n)); delta = 0.001; e = 0.4;
    P = createFJLT2projectionMatrix(k,d,beta);
    Phi = normc(P);
    tmp = zeros([4,n]);
    ct = zeros(1,n);
    for i = 1:n
        x = A(:,i);
        tic;
        px = Phi*x;
        ct(i) = toc;
        tmp(1,i) = (1-e)*norm(x,2);
        tmp(2,i) = norm(px,k);
        tmp(3,i) = (1+e)*norm(x,2);
        if ((tmp(2,i) >= tmp(1,i)) && (tmp(2,i) <= tmp(3,i)))
            tmp(4,i) = 1;
        else
            tmp(4,i) = 0;
        end
    end

    prob = sum(tmp(4,:))/n;
    %O = d*log(k);
    Average_ct = mean(ct);
    Max_ct = max(ct);
    
end