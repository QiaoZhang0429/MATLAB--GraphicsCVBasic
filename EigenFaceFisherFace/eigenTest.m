function [ testpreds ] = eigenTest( trainset, trainlabels, testset, W, mu, k )

%project train and test image to the space
train_k = (W * trainset')';%70 * 20
test_k = (W * testset')';
testpreds = nearestNeighbor( train_k, trainlabels, test_k );

end

