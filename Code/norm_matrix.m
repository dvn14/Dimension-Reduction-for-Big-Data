function pX = norm_matrix(X,Phi,rows,cols)
    tpX = Phi*X;
    pX = zeros(rows,cols);
    for i=1:rows
        x_min = min(tpX(i,:));
        x_max = max(tpX(i,:));
        pX(i,:) = (tpX(i,:) - x_min)/(x_max - x_min);
    end
end