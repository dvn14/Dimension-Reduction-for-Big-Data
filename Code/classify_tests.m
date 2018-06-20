function Class = classify_tests(TestData,TrainData,TrainTarget)
    class_index = knnsearch(TrainData',TestData','k',10)';
    [~,b] = size(class_index);
    Class = cell(b,1);
    for i=1:b
        all_classes = TrainTarget(class_index(:,i));
        [values, ~, inds] = unique(all_classes);
        Class(i) = cellstr(values{mode(inds)});
    end
end