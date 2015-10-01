%Test script for circularIndex.
%   The function in itself is sufficiently simple to be a lambda (as it's
%   only a single line of code), but because every programing language has
%   its own indexing and modulus implementation, a test is still
%   appropriate.
%
%Linus Narva (2015) linus.narva@gmail.com

n = 3;
idx = [-5,-4,-3,-2,-1,0,1,2,3,4,5];
expectedCinds = [1,2,3,1,2,3,1,2,3,1,2];

cinds = circularIndex(idx,n);

if any(cinds ~= expectedCinds)
   error('Incorrect circular indices!') 
end

disp('All tests passed!')