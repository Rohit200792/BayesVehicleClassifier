function best_class = CS6640_Bayes(x,class_probs,class_models)
% CS6640_Bayes - Bayes classifier
% On input:
%   x (mx1 vector): feature vector
%   class_pros (1xn vector): probabilities of n classes (sums to 1)
%   class_models (1xn vector struct): class models: means and
%       variances
%           (k).mean (mx1 vector): k_th class mean vector
%           (k).var (mxm array): k_th class covariance matrix
% On output:
%   best_class (int): index of best class for x
% Call:
%   c = CS6640_Bayes(x,cp,cm);
% Author:
%   Rohit Singh
%   UU
%   Fall 2018
%
no_of_classes=size(class_models,2);
n = length(x);
best_class=0;
p_last=-inf;
for class_no=1:no_of_classes
    m=class_models(class_no).mean;
    C=class_models(class_no).var;
    %term1 = ((2*pi)^(n/2))*((det(C))^(1/2));
    %term2 = -(((x-m)')*(inv(C))*(x-m))/2;
    term1=-(1/2)*(log(det(C)));
    term2 = -(((x-m)')*...
        (inv(C))*(x-m))/2;
    p = log(class_probs(class_no))+term1+term2;
    if (p>p_last)
        best_class=class_no;
        p_last=p;
    end
end




