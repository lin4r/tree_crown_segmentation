
%Test image.
img = imread('sample_tree_crowns.jpg');

%Point near the rop of a spruce crown.
posStart = [176;352];

%From Eriksson2003a
alpha = .15;
sigma1 = .36;

%A guess.
sigma2 = 100;

regionImg = expand(img,posStart,sigma1,sigma2,alpha);
imshow(regionImg);