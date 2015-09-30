function distanceImg = distanceTransform34(booleanImg)
%DISTANCETRANSFORM34 The 3,4 distance transform.
%   DISTANCEIMG = DISTANCETRANSFORM34(BOOLEANIMG) computes the 3,4 distance
%   transform of the foreground of logical BOOLEANIMG (i.e. pixels set to
%   true).
%
%   Indices outside the image border are assumed to be background, i.e.
%   border pixels have background neighbours.
%
%   Example
%       The image:  01000
%                   11100
%                   01000
%                   01110
%                   01110
%                   01110
%
%       Has the distance transform:
%                   03000
%                   34300
%                   03000
%                   03330
%                   03630
%                   03330
%
%   See also:
%       bwdist
%
%Linus Narva (2015) linus.narva@gmail.com

SE8NEIGHS = strel(ones(3));

%Insert a frame around the image.
bigBooleanImg = false(size(booleanImg)+[2,2]);
[M,N] = size(bigBooleanImg);
bigBooleanImg(2:M-1,2:N-1) = booleanImg;
booleanImg = bigBooleanImg;
clear bigBooleanImage;

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
        
        newDistances(i) = min([neigs4+3;neigsDiag+4]);
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

%Remove border
distanceImg = distanceImg(2:M-1,2:N-1);

end

