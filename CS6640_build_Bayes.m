function model = CS6640_build_Bayes(X)
% CS6640_build_Bayes - build Bayes model for dataset X
% On input:
%   X (nxm array): n samples of m-tuple feature vectors
% On output:
%   model (struct): model: mean and variance
%       .mean (mx1 vector): mean of X
%       .var (mxm array): covariance matrix of X
% Call:
%   m1 = CS6640_build_Bayes([0,0; 0.1,0; -0.1,0]);
% Author:
%    Rohit Singh
%    UU
%    Fall 2018
%
meanX = mean(X);
covX = cov(X);
model(1).mean=meanX';
model(1).var=covX;
model;
