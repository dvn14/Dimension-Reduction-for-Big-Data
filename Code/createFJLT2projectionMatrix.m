function PM = createFJLT2projectionMatrix(k, d, beta)
    % The projection matrix for FJLT method 2 is created here.

    x = d/beta;

    H_beta = createWalshHadamard(beta,0);
    D_beta = createRandomDiagonal(beta);

    rand_k = randperm(beta,k);
    B_k = normc(H_beta(rand_k,:));

    BD_kb = B_k*D_beta;
    PM = [];

    for i = 1:x
        HD_bb = H_beta*createRandomDiagonal(beta);
        BDHD  = BD_kb*HD_bb;
        PM = horzcat(PM,BDHD);
    end

end



