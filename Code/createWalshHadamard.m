function H = createWalshHadamard(d,x)
% H (dxd) is a Walsh-Hadamard fourier matrix
if x == 0 
    % without normalisation
    H = 2^(-d/2)*hadamard(d);
else
    % with normalisation
    H = (1/sqrt(d))*hadamard(d);
end
end