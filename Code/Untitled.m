load fisheriris.mat

X = zeros(32,150);

for i=1:4
    x_min = min(meas(:,i));
    x_max = max(meas(:,i));
    X(i,:) = (meas(:,i)' - x_min)/(x_max - x_min);
end

dir = 'results/knn/';

figure()
hold on
gscatter(X(1,:),X(2,:),species,'rgb','osd',[6,6,6]);
title('Original Iris Data Set')
xlabel('x1')
ylabel('x2')
hold off
saveas(gca, strcat(dir, 'normalised_data.png'));
% 
% figure()
% hold on
% gscatter(meas(:,3),meas(:,4),species,'rgb','osd',[6,6,6]);
% title('Original Iris Data Set')
% xlabel('Petal length')
% ylabel('Petal width')
% hold off
% saveas(gca, strcat(dir, 'original_fisheriris_2.png'));