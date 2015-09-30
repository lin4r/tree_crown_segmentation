function startingPointsImg = findStartingPoints(treeCrownImg ...
    ,intensityThresh)
%FINDSTARTINGPOINTS Implementation for finding starting points, based on
%the algorithm described in Eriksson2003a.
%   STARTINGPOINTSIMG = FINDSTARTINGPOINTS(TREECROWNIMAGE) computes the
%   starting points for region growing in the CIR image treeCrownImg. The
%   points are returned in a logical image.
%
%   ... = FINDSTARTINGPOINTS(...,INTENSITYTHRESH) allows for setting the
%   intensity threshhold (a value in [0,1]). Default is 0.3 as in the
%   paper.
%
%Linus Narva (2015) linus.narva@gmail.com

if nargin < 2
    intensityThresh = 0.3;
end

%Get the NIR channel and scale it to intensities [0,1].
nirchan = im2double(treeCrownImg(:,:,1));

%Threshold to find high intensity candidate points.
candidatePoints = nirchan > intensityThresh;

%Use the distance transform. Note that I use euclidean distance insteadd of
%3,4. This should not have a significant impact on performance.
distanceImg = bwdist(~candidatePoints,'euclidean');

%Find local maxima.
startingPointsImg = imregionalmax(distanceImg);

end

