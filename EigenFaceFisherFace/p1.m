[trainset trainlabels] = loadSubset(0);
testerror = zeros(4,1);
for subset = 1:4
    [testset testlabels] = loadSubset(subset);
    testpreds = zeros(size(testlabels));
    for i = 1:size(testset,1)
        min_dist = inf;
        for j = 1:size(trainset,1)
            dist = norm(testset(i,:) - trainset(j,:));
            if(dist < min_dist)
                testpreds(i) = trainlabels(j);
                min_dist = dist;
            end
        end
    end
    testerror(subset) = sum(testpreds ~= testlabels) * 1.0 / size(testset,1);
end