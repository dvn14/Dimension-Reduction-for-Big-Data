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

[prob_2, O_2, Average_ct_2, Max_ct_2, Phi_2, NZ_2] = fjlt1_inequality(150,2,32,0.45,X);
[prob_3, O_3, Average_ct_3, Max_ct_3, Phi_3, NZ_3] = fjlt1_inequality(150,3,32,0.45,X);
[Phi_4,prob_4,Average_ct_4,Max_ct_4] = fjlt2_prep(150,4,32,16,X,0.45);
[Phi_5,prob_5,Average_ct_5,Max_ct_5] = fjlt2_prep(150,5,32,16,X,0.45);

pX2 = norm_matrix(X,Phi_2,2,150);
pX3 = norm_matrix(X,Phi_3,3,150);
pX4 = norm_matrix(X,Phi_4,4,150);
pX5 = norm_matrix(X,Phi_5,5,150);

TestPoints = 5;
TestIdx = randperm(150,TestPoints);

[TestDataSet_X,TestTarget_X,SampleDataSet_X,SampleTarget_X,Plot_X] = seperate_data(TestIdx,X,species);
[TestDataSet_pX2,TestTarget_pX2,SampleDataSet_pX2,SampleTarget_pX2,Plot_pX2] = seperate_data(TestIdx,pX2,species);
[TestDataSet_pX3,TestTarget_pX3,SampleDataSet_pX3,SampleTarget_pX3,Plot_pX3] = seperate_data(TestIdx,pX3,species);
[TestDataSet_pX4,TestTarget_pX4,SampleDataSet_pX4,SampleTarget_pX4,Plot_pX4] = seperate_data(TestIdx,pX4,species);
[TestDataSet_pX5,TestTarget_pX5,SampleDataSet_pX5,SampleTarget_pX5,Plot_pX5] = seperate_data(TestIdx,pX5,species);

species(TestIdx) = [];
Plot_Y = vertcat(species, repmat(cellstr('query point'),TestPoints,1));

timestamp = datestr(now, 'dd-mm-yy_HH-MM-SS-FFF');
mkdir(['results/knn/',timestamp]);
dir = ['results/knn/',timestamp,'/'];

fileID = fopen(strcat(dir, 'knn_summary.txt'),'a');
knn_result(SampleDataSet_X,TestDataSet_X,SampleTarget_X,TestTarget_X,0,n,d,0,error,fileID);
knn_result(SampleDataSet_pX2,TestDataSet_pX2,SampleTarget_pX2,TestTarget_pX2,1,n,d,2,error,fileID);
knn_result(SampleDataSet_pX3,TestDataSet_pX3,SampleTarget_pX3,TestTarget_pX3,1,n,d,3,error,fileID);
knn_result(SampleDataSet_pX4,TestDataSet_pX4,SampleTarget_pX4,TestTarget_pX4,2,n,d,4,error,fileID);
knn_result(SampleDataSet_pX5,TestDataSet_pX5,SampleTarget_pX5,TestTarget_pX5,2,n,d,5,error,fileID);
fclose(fileID);

figure()
hold on
gscatter(Plot_X(1,:),Plot_X(2,:),Plot_Y,'rgbk','osdx',[6,6,6,10]);
title('Original Plot')
xlabel('Sepal length')
ylabel('Sepal width')
hold off
saveas(gca, strcat(dir, 'original.png'));

figure()
hold on
gscatter(Plot_pX2(1,:),Plot_pX2(2,:),Plot_Y,'rgbk','osdx',[6,6,6,10]);
title('FJLT 1 with k = 2')
xlabel('x1')
ylabel('x2')
hold off
saveas(gca, strcat(dir, '_FJLT_1_k2.png'));

figure()
hold on
gscatter(Plot_pX3(1,:),Plot_pX3(2,:),Plot_Y,'rgbk','osdx',[6,6,6,10]);
title('FJLT 1 with k = 3')
xlabel('x1')
ylabel('x2')
hold off
saveas(gca, strcat(dir, '_FJLT_1_k3.png'));

figure()
hold on
gscatter(Plot_pX4(1,:),Plot_pX4(2,:),Plot_Y,'rgbk','osdx',[6,6,6,10]);
title('FJLT 2 with k = 4')
xlabel('x1')
ylabel('x2')
hold off
saveas(gca, strcat(dir, '_FJLT_2_k4.png'));

figure()
hold on
gscatter(Plot_pX5(1,:),Plot_pX5(2,:),Plot_Y,'rgbk','osdx',[6,6,6,10]);
title('FJLT 2 with k = 5')
xlabel('x1')
ylabel('x2')
hold off
saveas(gca, strcat(dir, '_FJLT_2_k5.png'));


