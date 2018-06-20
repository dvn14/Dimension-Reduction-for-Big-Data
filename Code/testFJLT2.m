function testFJLT2(n,d,k,beta)
%clear;
%n = 50; d = 64; %beta and e 
X = rand(d,n);
% A = zeros(d,n);
% 
% for i=1:d
%     x_min = min(X(i,:));
%     x_max = max(X(i,:));
%     A(i,:) = (X(i,:) - x_min)/(x_max - x_min);
% end
A = normc(X);
%k = [2,3,4,5,8,16];
k_dim = length(k);
%beta = [4,16,16,24];
beta_dim = length(beta);

probs = zeros(k_dim,50); averageCompTime = zeros(k_dim,50); maxCompTime = zeros(k_dim,50);
aCTperK = zeros(1,k_dim);
highestProbAt = zeros(1,k_dim) -1;
% iteration for each k
for i = 1:k_dim
    disp(i);
    highestprob = 0;
    for e = 1:50
        c = 0;
        prob_1 = 0; act = 0; mct = 0;
        while 1
            [Phi,prob_2,Average_ct,Max_ct] = fjlt2_prep(n,k(i),d,beta(i),A,e/100);
            %prob_1 = prob_1 + prob_2;
            act = act + Average_ct;
            mct = mct + Max_ct;
            if prob_2 > prob_1
                prob_1 = prob_2;
            end
            if prob_2 > highestprob
                highestprob = prob_2;
                highestProbAt(i) = e/100;
            end
            if c == 50
                break;
            end
            c = c+1;
        end
        probs(i,e) = prob_1;
        averageCompTime(i,e) = act;
        maxCompTime(i,e) = mct;
    end
    aCTperK(i) = mean(averageCompTime(i,:));
end

e = 0.01:0.01:0.5;

dir = 'results/fjlt2/';
timestamp = datestr(now, 'dd-mm-yy_HH-MM-SS-FFF');

    figure()
    hold on
    xlabel('Error')
    ylabel('Probability of JLP')
    title(['Plot when n = ', num2str(n), ', d = ', num2str(d)])
    names = cell(1,k_dim);
for i = 1:k_dim
    plot(e,smoothdata(probs(i,:)), 'Markersize', 8);
    names{i} = strcat(['k = ',num2str(k(i))]);
end

    legend(names,'Location','northwest')
    hold off
    saveas(gca, strcat(dir, timestamp, ['_k','.png'])) 

    figure()
    hold on
    yyaxis left
    plot(k,smoothdata(highestProbAt), 'b-', 'Markersize', 8);
    title(['Plot when n = ', num2str(n), ', d = ', num2str(d)])
    xlabel('Embedded Dimension (k)')
    ylabel('Highest Probability at Error')

    yyaxis right
    plot(k,smoothdata(aCTperK), 'r-', 'Markersize', 8);
    ylabel('Average Computation Time (Sec)')

    legend({'Error','Average Computation Time'},'Location','northwest')
    hold off
    saveas(gca, strcat(dir, timestamp, ['_k_all','.png']))



% [prob, compTime, bigO, averageCompTime, projMatrix, nonZeros] = fjlt1_inequality(n,k,d,e,A);

 fileID = fopen(strcat(dir, 'resultslog.txt'),'a');
 fprintf(fileID, '%21s | ', timestamp);
 fprintf(fileID, '%6d | ', n);
 fprintf(fileID, '%6d | ', d);
 fprintf(fileID, '%6d | ', beta);
 fprintf(fileID, strcat(repmat('%10d ', 1, length(k)), ' | '), k);
 fprintf(fileID, strcat(repmat('%10.3f ', 1, length(highestProbAt)), ' | '), highestProbAt);
 fprintf(fileID, '\n');
 fclose(fileID);

% plot average probability vs error for a given d,n,k
end