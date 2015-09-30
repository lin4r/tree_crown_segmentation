function distanceImg = distanceTransform(booleanImg,w4,wDiag)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
   w4 = 3;
   wDiag = 4;
end

if nargin == 2
   error('Cannot specify W4 without also specifying WDIAG.') 
end

SE8NEIGHS = strel(ones(3));

%Initialize distanceImg, with infinity for foreground pixels.
distanceImg = zeros(size(booleanImg));
distanceImg(booleanImg) = Inf;

assignedPixels = ~booleanImg;

%Emulate a do-while loop.
isFinished = false;
while ~isFinished
    frontier = xor(assignedPixels, imdilate(assignedPixels,SE8NEIGHS));
    [xFront,yFront] = find(frontier);
    n = numel(xFront);
    newDistances = nan(n,1);
    
    %For every pixel in the frontier, assign a the shortest distance to the
    %edge, by examining the distance to the neighbours.
    for i = 1:n
        %Cut out the pixel neighbourhood.
        neighbourhood = distanceImg(xFront(i)-1:xFront(i)+1 ...
            ,yFront(i)-1:yFront(i)+1);
        
        %Get the neighbourhood distances.
        neigs4 = neighbourhood(logical([0,1,0;1,0,1;0,1,0]));
        neigsDiag = neighbourhood(logical([1,0,1;0,0,0;1,0,1]));
        
        newDistances(i) = min([neigs4+w4;neigsDiag+wDiag]);
    end
    
    if n == 0
        isFinished = true;
    else
        %Update distance image, mark frontier as asigned.
        distanceImg(sub2ind(size(distanceImg),xFront,yFront)) ...
            = newDistances;
        assignedPixels = or(assignedPixels,frontier);
    end
end

end

