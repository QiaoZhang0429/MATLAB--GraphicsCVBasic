[trainset trainlabels] = loadSubset(0);
k = 5;%3,5
testerror = zeros(4,1);
for subset = 1:4
    [testset testlabels] = loadSubset(subset);
    testpreds = zeros(size(testlabels));
    for i = 1:size(testset,1)
        min_dist = inf(k,1);
        min_label = zeros(k,1);
        for j = 1:size(trainset,1)
            dist = norm(testset(i,:) - trainset(j,:));
            [y,index] = max(min_dist);
            if(dist < y)
                min_dist(index) = dist;
                min_label(index) = trainlabels(j);
            end
        end
        testpreds(i) = mode(min_label);
    end
    testerror(subset) = sum(testpreds ~= testlabels) * 1.0 / size(testset,1);
end