function [] = renderImg2(facedata)

    load(facedata);
    numX = size(heightmap,1);
    numY = size(heightmap,2);
    
    %initialization for image produced by combining light sources
    comb1 = zeros(size(heightmap));
    comb2 = zeros(size(heightmap));
    
    %calculate the norm vectors using surfaceNorm function
    [U,V,W] = surfaceNorm(facedata);
    figure
    for ls = 1:size(lightsource,1)
        lsource = lightsource(ls,:);
        UVW = [reshape(U,1,numX*numY);reshape(V,1,numX*numY);reshape(W,1,numX*numY)];
        
        %calculate direction matrix where each column is a direction
        %vector
        direction(1,:) = lsource(1) - repmat(1:numX,1,numY);
        direction(2,:) = lsource(2) - reshape(repmat((1:numY)',1,numX)',1,numX*numY);
        direction(3,:) = lsource(3) - reshape(heightmap,1,numX*numY);
        
        %distance is a vector and each element is the norm of a column of
        %direction matrix
        distance = sum(direction.^2,1);
        
        %normalization
        direction = bsxfun(@rdivide,direction,sqrt(distance));
        distance = reshape(distance,numX,numY);
        
        %calculate the dot product of norm vector and direction vector
        angel = dot(UVW,direction,1);
        angel = reshape(angel,numX,numY);
        img1 = albedo.*angel.*ones(numX,numY)./distance;
        comb1 = comb1 + img1;
        img2 = uniform_albedo.*angel.*ones(numX,numY)./distance;
        comb2 = comb2 + img2;
        
        %plotting two single light sources with different albedo map
        subplot(2,3,ls*2-1)
        imagesc(img1)
        title(strcat('light source',num2str(ls),'with albedo'))
        subplot(2,3,ls*2)
        imagesc(img2)
        title(strcat('light source',num2str(ls),'with uniform albedo'))
    end
    
    %plotting the combined light source with different albedo map
    subplot(2,3,5)
    imagesc(comb1)
    title('2 lightsources with albedo')
    subplot(2,3,6)
    imagesc(comb2)
    title('2 lightsources  uniform albedo')
end