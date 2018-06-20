function comparison(d,n,k_up,beta,error)
% d = 32;
% n = 5000;
% k_up= 12;
% beta = [4,16,16,16,32,32,32,32,32,32,32];
% error = 0.45;
it = 10;

A = normc(rand(d,n));
k = 2:k_up;
beta_dim = length(beta);
k_dim = length(k);
pos1 = zeros(1,k_dim);
pos2 = zeros(1,k_dim);
act1 = zeros(1,k_dim);
act2 = zeros(1,k_dim);

for i = 1:k_dim
    disp(['k = ',num2str(i),'; ']);
    % for each k
    prob1 = 0;
    ct1 = 0;
    prob2 = 0;
    ct2 = 0;
    for j = 1:it
        [prob_1, O, Average_ct_1, Max_ct, Phi, NZ] = fjlt1_inequality(n,k(i),d,error,A);
        prob1 = prob1 + prob_1;
        ct1 = ct1 + Average_ct_1;
        
        [Phi,prob_2,Average_ct_2,Max_ct_2] = fjlt2_prep(n,k(i),d,beta(i),A,error);
        prob2 = prob2 + prob_2;
        ct2 = ct2 + Average_ct_2;
    end
    pos1(i) = prob1/it;
    pos2(i) = prob2/it;
    act1(i) = ct1/it;
    act2(i) = ct2/it;    
end

dir = ['results/Comparison/d',num2str(d),'/'];
timestamp = datestr(now, 'dd-mm-yy_HH-MM-SS-FFF');

figure()
hold on
plot(k,smoothdata(pos1),'b-',k,smoothdata(pos2),'g-','Markersize',8);
legend({'FJLT 1','FJLT 2'},'Location','northeast')
title(['Success when n = ', num2str(n), ', d = ', num2str(d)])
xlabel('Reduced dimension (k)')
ylabel('Probability of Success')
hold off
saveas(gca, strcat(dir, timestamp, ['_n_',num2str(n),'_d_',num2str(d),'_e_',num2str(error),'.png']))

figure()
hold on
plot(k,smoothdata(act1),'b-',k,smoothdata(act2),'g-','Markersize',8);
legend({'FJLT 1','FJLT 2'},'Location','northeast')
title(['Computation Time when n = ', num2str(n), ', d = ', num2str(d)])
xlabel('Reduced dimension (k)')
ylabel('Computation Time')
hold off
saveas(gca, strcat(dir, timestamp, ['_n_',num2str(n),'_d_',num2str(d),'_e_',num2str(error),'_comptime.png']))

dir1 = 'results/Comparison/';

 fileID = fopen(strcat(dir1, 'resultslog.txt'),'a');
 fprintf(fileID, '%21s | ', timestamp);
 fprintf(fileID, '%6d | ', n);
 fprintf(fileID, '%6d | ', d);
 fprintf(fileID, '%6d | ', error);
 fprintf(fileID, '%6d | ', k_up);
 fprintf(fileID, '\n');
 fclose(fileID);
end

