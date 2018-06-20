function knn_result(SampleDataSet,TestDataSet,SampleTarget,TestTarget,Type,SampleSize,d,k,error,fileID)
    class_index = knnsearch(SampleDataSet',TestDataSet','k',11)';
    [~,b] = size(class_index);
    PredictedTarget = cell(length(TestTarget),1);
    for i=1:b
        all_classes = SampleTarget(class_index(:,i));
        [values, ~, inds] = unique(all_classes);
        PredictedTarget(i) = cellstr(values{mode(inds)});
    end
    
    fprintf(fileID, 'Sample Size = %6d | ', SampleSize);
    fprintf(fileID, 'FJLT type: %6d | ', Type);
    fprintf(fileID, 'd = %6d | ', d);
    fprintf(fileID, 'k = %6d | ', k);
    fprintf(fileID, 'error = %6d | ', error);
    fprintf(fileID, 'Actual = [ ');
    fprintf(fileID, ' %s ', string(TestTarget'));
    fprintf(fileID, ' ] | ');
    fprintf(fileID, 'Predicted = [ ');
    fprintf(fileID, ' %s ', string(PredictedTarget'));
    fprintf(fileID, ' ]');
    fprintf(fileID, '\n');
end