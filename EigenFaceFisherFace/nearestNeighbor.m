function [ testpreds ] = nearestNeighbor( trainset, trainlabels, testset )
 
    testpreds = zeros(size(testset,1),1);
    for i = 1:size(testset,1)
        min_dist = inf;
        for j = 1:size(trainset,1)
            dist = norm(testset(i,:) - trainset(j,:));
            if(dist < min_dist)
                testpreds(i,1) = trainlabels(j);
                min_dist = dist;
            end
        end
    end

end

