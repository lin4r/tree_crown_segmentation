function regionImg = expand(img,posStart,sigma1,sigma2,alpha)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
%Linus Narva (2015) linus.narva@gmail.com

getirg = @(img,pos) reshape(img(pos(1),pos(2),:),[],1);

imgd = im2double(img);
[m,n,~] = size(imgd);
irgStart = getirg(imgd,posStart);
regionImg = false(m,n);

%Mark the seed (start point) as a region member.
regionImg(posStart(1),posStart(2)) = true;

%do-while add point til there is no point to add.
anyNewMembers = true;

while anyNewMembers
    anyNewMembers = false;

    frontier = outerRegionBoundary(regionImg);
    [xFront,yFront] = find(frontier);
    frontPos = [xFront,yFront];
    
    %Check all frontier points for membership.
    k = numel(xFront);
    for i = 1:k
        pos = frontPos(i,:)';
        irg = getirg(imgd,pos);
        isRegionMember = checkRegionMembership(posStart,irgStart ...
            ,pos,irg,sigma1,sigma2,alpha);
        
        if isRegionMember
           regionImg(pos(1),pos(2)) = true; 
           anyNewMembers = true;
        end
    end
end

end

function boundary = outerRegionBoundary(region)
    neighbourhoodSE = strel(ones(3)); %8 neighbourhood.
    boundary = xor(region,imdilate(region,neighbourhoodSE));
end

%TODO vector operations
function [isConnected,mu] = checkRegionMembership( ...
    posStart,irgStart,pos,irg,sigma1,sigma2,alpha)

xd = posStart - pos;
irgd = irgStart - irg;

%Computes a partial weight based on distance.
expansionWeight = @(x,sigma) exp(-0.5*dot(x,x)/sigma/sigma);

mu1 = expansionWeight(irgd,sigma1); %Coulor distance weight.
mu2 = expansionWeight(xd,sigma2); %Distance weight.

mu = mu1*mu2;

isConnected = alpha < mu;
end