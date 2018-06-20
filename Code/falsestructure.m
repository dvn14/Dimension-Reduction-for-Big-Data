clear;
n = 5000;
m = 5000;

X = randn(n,m);

EmpiricalCovMatrix = (1/m)*X*transpose(X);
all_Eigenvalues     = eig(EmpiricalCovMatrix);
rounded_Eigenvalues = round(all_Eigenvalues,2);
eigenvalues = tabulate(rounded_Eigenvalues);

dir = 'results/other/';
timestamp = datestr(now, 'dd-mm-yy_HH-MM-SS-FFF');
figure();
hold on
    histogram(all_Eigenvalues,[0 min(all_Eigenvalues):0.05:max(all_Eigenvalues)+0.05 4.5]);
    title(['Eigenvalues of $$\hat{\sum}$$ for n = ', num2str(n), ', m = ', num2str(m)],'interpreter','latex')
    xlabel('Eigenvalue')
    hold off
    saveas(gca, strcat(dir, timestamp, ['n_', num2str(n), '_m_', num2str(m),'.png']))