function D = createRandomDiagonal(d)
% D (dxd) is a random diagonal matrix whose elements are 
% +/- 1 with probability 0.5

diagonalElements = datasample([-1,1],d,'Weights',[0.5 0.5]);
D = diag(diagonalElements);

end