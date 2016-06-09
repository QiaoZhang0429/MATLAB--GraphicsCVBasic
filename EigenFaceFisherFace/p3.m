%3.1
[trainset trainlabels] = loadSubset(0);
k = 20;
[W, mu] = eigenTrain(trainset, k);
%3.2
imshow(drawFaces(W.*20,2));
%3.4

X = [];
x=[];
for i = 1:10
    i
    for k = 1:10
        x = trainset(7*(i-1)+1,:);
        x = x';
        [W, mu] = eigenTrain(trainset, k);
        x = W' * W * (x-mu')+mu';
        X = [X x];
    end
end
find(X==0)
Y = zeros(500,500);
for i = 1:10
    for j = 1:10
        Y(1+50*(i-1):50*i,1+50*(j-1):50*j) = reshape(X(:,j+10*(i-1)),50,50);
    end
end
imshow(Y);
3.5
testerror = zeros(20,4);
for k = 1:20
    [W,mu] = eigenTrain(trainset, k);
    for subset = 1:4
        [testset testlabels] = loadSubset(subset);
        testpreds = eigenTest( trainset, trainlabels, testset, W, mu, k );
        testerror(k,subset) = sum(testpreds ~= testlabels) * 1.0 / size(testset,1);
    end
end
x = 1:20;
plot(x,testerror(:,1)',x,testerror(:,2)',x,testerror(:,3)',x,testerror(:,4)');
legend('subset1','subset2','subset3','subset4');
%3.6
testerror5 = zeros(20,4);
for k = 1:20
    [W,mu] = eigenTrain5(trainset, k);
    for subset = 1:4
        [testset testlabels] = loadSubset(subset);
        testpreds = eigenTest( trainset, trainlabels, testset, W, mu, k );
        testerror5(k,subset) = sum(testpreds ~= testlabels) * 1.0 / size(testset,1);
    end
end
x = 1:20;
plot(x,testerror5(:,1)',x,testerror5(:,2)',x,testerror5(:,3)',x,testerror5(:,4)');
legend('subset1','subset2','subset3','subset4');

%3.7
[trainset trainlabels] = loadSubset(0);
testerror = zeros(4,10);
for num_eig = 50:50:500
    num_eig
    [W, mu] = eigenTrain(trainset, num_eig);
    for subset = 1:4
        [testset testlabels] = loadSubset(subset);
        testpreds = eigenTest( trainset, trainlabels, testset, W, mu, num_eig );
        testerror(subset,num_eig/50) = sum(testpreds ~= testlabels) * 1.0 / size(testset,1);
    end  
end
x = 50:50:500;
plot(x,testerror(1,:),x,testerror(2,:),x,testerror(3,:),x,testerror(4,:));
xlabel('# eigenvalues');
ylabel('error rate');
legend('subset1','subset2','subset3','subset4');
