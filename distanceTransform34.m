function distanceImg = distanceTransform34(booleanImg)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[m,n] = size(booleanImg);

%Initially all 0s have the correct distance (0).
hasAssignedDistance = ~booleanImg;

fourConnection = strel([0,1,0;1,1,1;0,1,0]);
diagonalConnection = strel([1,0,1;0,1,0;1,0,1]);

distanceImage = zeros(size(hasAssignedDistance));

fourFrontier = imdilate(distanceImage,fourConnection)

end

