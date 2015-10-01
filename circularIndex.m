function cind = circularIndex(inds,n)
%CIRCULARINDEX computes the circular index corresponding to a linear index
%that might be out of bounds.
%   CIND = CIRCULARINDEX(INDS,N) where INDS is a vector of linear indices
%   that can be out of bounds, i.e. outside [1,N] where N is the vector
%   length. CIND is the circular index.
%
%Linus Narva (2015) linus.narva@gmail.com

cind = mod(inds-1,n)+1;

end

