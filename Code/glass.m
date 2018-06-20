clear;
all_data = xlsread('glass.xlsx');
[a,b] = size(all_data);

data  = all_data(:,2:end-1);
class = all_data(:,end);

X = zeros(b-2,a);

for i=1:(b-2)
    x_min = min(data(:,i));
    x_max = max(data(:,i));
    X(i,:) = (data(:,i)' - x_min)/(x_max - x_min);
end

figure()
hold on
gscatter(X(9,:),X(8,:),class,'rgbymk','osdp*x');
title('Original Glass Identification Data Set')
xlabel('x1')
ylabel('x2')
hold off