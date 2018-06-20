function accuracy = knn_get_accuracy(SampleDataSet,TestDataSet,SampleTarget,TestTarget)
    class_index = knnsearch(SampleDataSet',TestDataSet','k',11)';
    [~,b] = size(class_index);
    PredictedTarget = cell(length(TestTarget),1);
    acc = 0;
    for i=1:b
        all_classes = SampleTarget(class_index(:,i));
        [values, ~, inds] = unique(all_classes);
        PredictedTarget(i) = cellstr(values{mode(inds)});
        if isequal(PredictedTarget(i),TestTarget(i)) == 1
            acc = acc +1;
        end
    end
    accuracy = acc/length(TestTarget);
end