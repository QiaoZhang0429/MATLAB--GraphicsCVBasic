%4.1
[trainset trainlabels] = loadSubset(0);
c = 10;
[W,mu]=fisherTrain(trainset,trainlabels,c);
%4.2
imshow(drawFaces(W.*10,1));
%4.3
testerror = zeros(9,4);
for k = 1:9
    [W,mu] = fisherTrain(trainset,trainlabels,c);
    W = W(1:k,:);
    for subset = 1:4
        [testset testlabels] = loadSubset(subset);
        testpreds = eigenTest( trainset, trainlabels, testset, W, mu, k );
        testerror(k,subset) = sum(testpreds ~= testlabels) * 1.0 / size(testset,1);
    end
end
x = 1:9;
plot(x,testerror(:,1)',x,testerror(:,2)',x,testerror(:,3)',x,testerror(:,4)');
legend('subset1','subset2','subset3','subset4');
