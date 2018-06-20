function B_k = createSubCodeMatrix(k,beta)
% Create the sub matrix of B which is used to
% make copies side by side.

temp1 = rand([k beta]);
temp2 = zeros(k,beta);
for i = 1:1:beta
    temp2(:,i) = temp1(:,i)/norm(temp1(:,i));
end

B_k = temp2;
end

