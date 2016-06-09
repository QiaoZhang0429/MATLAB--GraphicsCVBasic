function [ W,mu ] = eigenTrain( trainset, k )

%mu
mu = mean(trainset,1);
%W
x = trainset';
x = x - repmat(mean(x,1),size(x,1),1);
sigma = x * x' / size(x,2);
[U,S,V] = svd(sigma);
W = U(:,1:k)';

end

