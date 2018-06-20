function [TestDataSet,TestTarget,SampleDataSet,SampleTarget,Plot_X] = seperate_data(TestIdx,X,Y)
    TestDataSet = X(:,TestIdx);
    TestTarget  = Y(TestIdx);
    X(:,TestIdx) = [];
    SampleDataSet = X;
    Y(TestIdx) = [];
    SampleTarget = Y;
    Plot_X = horzcat(X,TestDataSet);
end