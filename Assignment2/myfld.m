% MYFLD classifies an input sample into either class 1 or class 2.
%
%   [output_class, w, s_w, mean_c1, mean_c2] = myfld(input_sample, class1_samples, class2_samples)
%   classifies an input sample into either class 1 or class 2,
%   from samples of class 1 (class1_samples) and samples of
%   class 2 (class2_samples).
% 
% The implementation of the Fisher linear discriminant must follow the
% descriptions given in the lecture notes.
% In this assignment, you do not need to handle cases when 'inv' function
% input is a matrix which is badly scaled, singular or nearly singular.
% All calculations are done using double-precision floating point. 
%
% Input parameters:
% input_sample = an input sample
%   - The number of dimensions of the input sample is N.
%
% class1_samples = a NC1xN matrix
%   - class1_samples contains all samples taken from class 1.
%   - The number of samples is NC1.
%   - The number of dimensions of each sample is N.
%
% class2_samples = a NC2xN matrix
%   - class2_samples contains all samples taken from class 2.
%   - The number of samples is NC2.
%   - NC1 and NC2 do not need to be the same.
%   - The number of dimensions of each sample is N.
%
% Output parameters:
% output_class = the class to which input_sample belongs. 
%   - output_class should have the value either 1 or 2.
%
% w = weight vector.
%   - The vector length must be one.
%
% s_w = within-class scatter matrix
%
% mean_c1 = mean vector of Class 1 samples
%
% mean_c2 = mean vector of Class 2 samples
%
% For ALL submitted files in this assignment, 
%   you CANNOT use the following MATLAB functions:
%   mean, diff, classify, classregtree, eval, mahal.
function [output_class, w, s_w, mean_c1, mean_c2] = myfld(input_sample, class1_samples, class2_samples)

[NC1,N1]=size(class1_samples);
[NC2,N2]=size(class2_samples);
if N1==N2
    N=N1;
else
    N=0;
end
    
mean_c1=zeros(1,2);
mean_c2=zeros(1,2); 
for i=1:NC1  %计算类1平均向量
    mean_c1=mean_c1+class1_samples(i,:);
end
mean_c1=mean_c1/NC1;
for i=1:NC2  %计算类2平均向量
    mean_c2=mean_c2+class2_samples(i,:);
end
mean_c2=mean_c2/NC2;


%计算Si和Sa和Sw
s_i=zeros(N,N);
s_a=zeros(N,N);
for i=1:NC1
    s_i=s_i+(class1_samples(i,:)-mean_c1)'*(class1_samples(i,:)-mean_c1);
end
for i=1:NC2
    s_a=s_a+(class2_samples(i,:)-mean_c2)'*(class2_samples(i,:)-mean_c2);
end
s_w=s_i+s_a;

%计算weight vector和判别点
w=inv(s_w)*(mean_c1-mean_c2)';

separation=0.5*w'*(mean_c1+mean_c2)';

total=0;
for i=1:size(w,1)
    total=w(i)^2+total;
end
for k=1:size(w,1)
    w(k)=w(k)/(sqrt(total));
end


%进行判别
if input_sample*w>separation
    output_class=1;
else
    output_class=2;
end


end

