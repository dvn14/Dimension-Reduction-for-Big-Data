load fisheriris 
indices = crossvalind('Kfold',species,10);

X = zeros(32,150);

for i=1:4
    x_min = min(meas(:,i));
    x_max = max(meas(:,i));
    X(i,:) = (meas(:,i)' - x_min)/(x_max - x_min);
end

fjlt1error = zeros(1,9); 
fjlt2error = zeros(1,9);
er = zeros(1,10)+1;
for i = 1:10
    X_CP = create_cp(species,indices,X);
    if X_CP.ErrorRate < min(er)
        OP = X_CP;
    end
    er(i) = X_CP.ErrorRate;
end

%[CP,average_error] = fjlt_cross_val(Type,k,beta,X,species,indices);
[CP_1_2,fjlt1error(1)] = fjlt_cross_val(1,2,0,X,species,indices);
[CP_1_3,fjlt1error(2)] = fjlt_cross_val(1,3,0,X,species,indices);
[CP_1_4,fjlt1error(3)] = fjlt_cross_val(1,4,0,X,species,indices);
[CP_1_5,fjlt1error(4)] = fjlt_cross_val(1,5,0,X,species,indices);
[CP_1_6,fjlt1error(5)] = fjlt_cross_val(1,6,0,X,species,indices);
[CP_1_7,fjlt1error(6)] = fjlt_cross_val(1,7,0,X,species,indices);
[CP_1_8,fjlt1error(7)] = fjlt_cross_val(1,8,0,X,species,indices);
[CP_1_9,fjlt1error(8)] = fjlt_cross_val(1,9,0,X,species,indices);
[CP_1_10,fjlt1error(9)]= fjlt_cross_val(1,10,0,X,species,indices);

[CP_2_2,fjlt2error(1)] = fjlt_cross_val(2,2,4,X,species,indices);
[CP_2_3,fjlt2error(2)] = fjlt_cross_val(2,3,16,X,species,indices);
[CP_2_4,fjlt2error(3)] = fjlt_cross_val(2,4,16,X,species,indices);
[CP_2_5,fjlt2error(4)] = fjlt_cross_val(2,5,16,X,species,indices);
[CP_2_6,fjlt2error(5)] = fjlt_cross_val(2,6,32,X,species,indices);
[CP_2_7,fjlt2error(6)] = fjlt_cross_val(2,7,32,X,species,indices);
[CP_2_8,fjlt2error(7)] = fjlt_cross_val(2,8,32,X,species,indices);
[CP_2_9,fjlt2error(8)] = fjlt_cross_val(2,9,32,X,species,indices);
[CP_2_10,fjlt2error(9)] = fjlt_cross_val(2,10,32,X,species,indices);

k = 2:1:10;

dir = 'results/knn/crossval/';
timestamp = datestr(now, 'dd-mm-yy_HH-MM-SS-FFF');

figure()
hold on
plot(k,smoothdata(fjlt1error),'b-',k,smoothdata(fjlt2error),'g-',k,ones(1,length(k))*mean(er),'r--','Markersize',8)
title('Cross Validation for Reduced Dimensions')
xlabel('Reduced Dimension (k)')
ylabel('Classification Error (%)')
legend({'FJLT 1','FJLT 2','Original'},'Location','northeast')
hold off
saveas(gca, strcat(dir, timestamp, 'cross_validation_error.png'))

mean(er)
OP.ClassLabels
OP.CountingMatrix

CP_1_2.ErrorRate
CP_1_2.ClassLabels
CP_1_2.CountingMatrix

CP_1_3.ErrorRate
CP_1_3.ClassLabels
CP_1_3.CountingMatrix

CP_2_4.ErrorRate
CP_2_4.ClassLabels
CP_2_4.CountingMatrix

CP_2_5.ErrorRate
CP_2_5.ClassLabels
CP_2_5.CountingMatrix