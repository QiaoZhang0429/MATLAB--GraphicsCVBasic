function [W,mu] = fisherTrain(trainset,trainlabels,c)
N = size(trainset,1);
k = N-c;
[WPCA,mu] = eigenTrain(trainset,k);
train_p = (WPCA * trainset')';%70*60
mu_p = (WPCA*mu')';%1*60
SB = zeros(k,k);%60*60
SW = zeros(k,k);
for i = 1:10
    Xi = train_p((i-1)*(N/c)+1:i*(N/c),:);%7*60
    mu_i = mean(Xi,1);
    SB = SB + N/c*(mu_i-mu_p)'*(mu_i-mu_p);
    mu_i = repmat(mu_i,N/c,1);%7*70
    SW = SW + (Xi-mu_i)'*(Xi-mu_i);
end
[V,lambda] = eig(SB,SW);
WFLD = V(:,1:c-1);
W = WFLD'*WPCA;
end
