clear;
n = 100; d = 128; 
A = rand(d,n);
k = [2,4,8,16,32,64];
k_dim = length(k);
prob = zeros(k_dim,50); averageCompTime = zeros(k_dim,50); maxCompTime = zeros(k_dim,50);
probTwoThirdsAt = zeros(1,k_dim) -1;
aCTperK = zeros(1,k_dim);
% iteration for each k
for i = 1:k_dim
    %iteration for each e
    disp(i);
    for e = 1:50
        %iteration to take the average
        prob_1 = 0;
        averageCompTime_1 = 0;
        averageMaxCompTime_1 = 0;
        for j = 1:1:20
            [prob_2, bigO, averageCompTime_2, averageMaxCompTime_2, projMatrix, nonZeros] = fjlt1_inequality(n,k(i),d,e/50,A);
            prob_1 = prob_1 + prob_2;
            averageCompTime_1 = averageCompTime_1 + averageCompTime_2;
            averageMaxCompTime_1 = averageMaxCompTime_1 + averageMaxCompTime_2;
        end
        prob(i,e) = (prob_1)/20;
        averageCompTime(i,e) = (averageCompTime_1)/20;
        maxCompTime(i,e) = (averageMaxCompTime_1)/20;
        if ((prob(i,e) >= 2/3 ) && (probTwoThirdsAt(i) == -1))
            probTwoThirdsAt(i) = e/50;
        end
    end
    aCTperK(i) = mean(averageCompTime(i,:));
end

e = 0.02:0.02:1;

dir = 'results/';
timestamp = datestr(now, 'dd-mm-yy_HH-MM-SS-FFF');

for i = 1:k_dim
    figure()
    hold on
    yyaxis left
    plot(e,prob(i,:), 'b-', 'Markersize', 8);
    title(['Plot when n = ', num2str(n), ', d = ', num2str(d), ', and k = ', num2str(k(i))])
    xlabel('Error')
    ylabel('Average Probability')

    yyaxis right
    plot(e,averageCompTime(i,:), 'r-', 'Markersize', 8);
    ylabel('Average Computation Time (Sec)')

    legend({'Error','Average Computation Time'},'Location','northwest')
    hold off
    saveas(gca, strcat(dir, timestamp, ['_k_',num2str(k(i)),'.png'])) 
end

    figure()
    hold on
    yyaxis left
    plot(k,probTwoThirdsAt, 'b-', 'Markersize', 8);
    title(['Plot when n = ', num2str(n), ', d = ', num2str(d)])
    xlabel('Embedded Dimension (k)')
    ylabel('2/3 probability at error')

    yyaxis right
    plot(k,aCTperK, 'r-', 'Markersize', 8);
    ylabel('Average Computation Time (Sec)')

    legend({'Error','Average Computation Time'},'Location','northwest')
    hold off
    saveas(gca, strcat(dir, timestamp, ['_k_all','.png']))



% [prob, compTime, bigO, averageCompTime, projMatrix, nonZeros] = fjlt1_inequality(n,k,d,e,A);

fileID = fopen(strcat(dir, 'resultslog.txt'),'a');
fprintf(fileID, '%21s | ', timestamp);
fprintf(fileID, '%6d | ', n);
fprintf(fileID, '%6d | ', d);
fprintf(fileID, strcat(repmat('%10d ', 1, length(k)), ' | '), k);
fprintf(fileID, strcat(repmat('%10.3f ', 1, length(probTwoThirdsAt)), ' | '), probTwoThirdsAt);
fprintf(fileID, '\n');
fclose(fileID);

% plot average probability vs error for a given d,n,k