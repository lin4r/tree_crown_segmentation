function [isConnected,mu] = expand(xStart,irgStart,x,irg ...
    ,sigma1,sigma2,alpha)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
%Linus Narva (2015) linus.narva@gmail.com

xd = xStart - x;
irgd = irgStart - irg;

%Computes a partial weight based on distance.
expansionWeight = @(x,sigma) exp(-0.5*dot(x,x)/sigma);

mu1 = expansionWeight(irgd,sigma1); %Coulor distance weight.
mu2 = expansionWeight(xd,sigma2); %Distance weight.

mu = mu1*mu2;

isConnected = alpha < mu;

end