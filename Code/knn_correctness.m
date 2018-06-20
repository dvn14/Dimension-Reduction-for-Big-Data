clear;
load fisheriris;
measT=meas';
n = 150;
d=32;
error = 0.45;
X = zeros(32,150);

for i=1:4
    x_min = min(meas(:,i));
    x_max = max(meas(:,i));
    X(i,:) = (meas(:,i)' - x_min)/(x_max - x_min);
end

timestamp = datestr(now, 'dd-mm-yy_HH-MM-SS-FFF');
dir = 'results/knn_accuracy/';
fileID = fopen(strcat(dir, 'knn_summary.txt'),'a');

k = [2,3,4,5,6,7,8,9,10];
b = [4,8,16,16,32,32,32,32,32];
TestPoints = 15;
TestIdx = randperm(150,TestPoints);

fprintf(fileID, '%21s | ', timestamp);
fprintf(fileID, '\n');
fprintf(fileID, 'SS = %6d | ', n);
fprintf(fileID, 'FJLT: %6d | ', 0);
fprintf(fileID, 'd = %6d | ', d);
fprintf(fileID, 'k = %6d | ', 32);
fprintf(fileID, 'er = %6.3f | ', error);
fprintf(fileID, 'TP = %3d | ', TestPoints);

[TestDataSet_X,TestTarget_X,SampleDataSet_X,SampleTarget_X,Plot_X] = seperate_data(TestIdx,X,species);
acc = 0;
for j = 1:10
    acc0 = knn_get_accuracy(SampleDataSet_X,TestDataSet_X,SampleTarget_X,TestTarget_X);
    acc = acc + acc0;
end
acc = acc/10;

fprintf(fileID,'accuracy = %6.1f | ', 100*acc);
fprintf(fileID, '\n');

for i = 1:length(k)
    acc1 = 0;
    for j = 1:10
        [prob_1, O_1, Average_ct_1, Max_ct_1, Phi_1, NZ_1] = fjlt1_inequality(150,k(i),32,0.4,X);
        pX1 = norm_matrix(X,Phi_1,k(i),150);
        [TestDataSet_pX1,TestTarget_pX1,SampleDataSet_pX1,SampleTarget_pX1,Plot_pX1] = seperate_data(TestIdx,pX1,species);
        acc10 = knn_get_accuracy(SampleDataSet_pX1,TestDataSet_pX1,SampleTarget_pX1,TestTarget_pX1);
        acc1 = acc1 + acc10;
    end
    acc1 = acc1/10;
    fprintf(fileID, 'SS = %6d | ', n);
    fprintf(fileID, 'FJLT: %6d | ', 1);
    fprintf(fileID, 'd = %6d | ', d);
    fprintf(fileID, 'k = %6d | ', k(i));
    fprintf(fileID, 'er = %6.3f | ', error);
    fprintf(fileID, 'TP = %3d | ', TestPoints);
    fprintf(fileID,'accuracy = %6.1f | ', 100*acc1);
    fprintf(fileID, '\n');
end

for i = 1:length(k)
    acc2 = 0;
    for j = 1:10
        [Phi_2,prob_2,Average_ct_2,Max_ct_2] = fjlt2_prep(150,k(i),32,b(i),X,0.4);
        pX2 = norm_matrix(X,Phi_2,k(i),150);
        [TestDataSet_pX2,TestTarget_pX2,SampleDataSet_pX2,SampleTarget_pX2,Plot_pX2] = seperate_data(TestIdx,pX2,species);
        acc20 = knn_get_accuracy(SampleDataSet_pX2,TestDataSet_pX2,SampleTarget_pX2,TestTarget_pX2);
        acc2 = acc2 + acc20;
    end
    acc2 = acc2/10;
    fprintf(fileID, 'SS = %6d | ', n);
    fprintf(fileID, 'FJLT: %6d | ', 2);
    fprintf(fileID, 'd = %6d | ', d);
    fprintf(fileID, 'k = %6d | ', k(i));
    fprintf(fileID, 'er = %6.3f | ', error);
    fprintf(fileID, 'TP = %3d | ', TestPoints);
    fprintf(fileID,'accuracy = %6.1f | ', 100*acc2);
    fprintf(fileID, '\n');
end

fclose(fileID);
%%%%%%%%%%%%%%%%%%%%
