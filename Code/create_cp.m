function CP = create_cp(species,indices,X)
    CP = classperf(species);

    for i = 1:10
        test = (indices == i); train = ~test;
        class = classify_tests(X(:,test),X(:,train),species(train,:));
        classperf(CP,class,test)
    end
end