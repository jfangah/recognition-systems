% myprewittedge computes a binary edge image from the given image.
%
%   g = myprewittedge(Im,T,direction) computes the binary edge image from the
%   input image Im.
%   
% The function myprewittedge, with the format g=myprewittedge(Im,T,direction), 
% computes the binary edge image from the input image Im. This function takes 
% an intensity image Im as its input, and returns a binary image g of the 
% same size as Im (mxn), with 1's where the function finds edges in Im and 0's 
% elsewhere. This function finds edges using the Prewitt approximation to the 
% derivatives with the assumption that input image values outside the bounds 
% are zero and all calculations are done using double-precision floating 
% point. The function returns g with size mxn. The image g contains edges at 
% those points where the absolute filter response is above or equal to the 
% threshold T.
%   
%       Input parameters:
%       Im = An intensity gray scale image.
%       T = Threshold for generating the binary output image. If you do not
%       specify T, or if T is empty ([ ]), myprewittedge(Im,[],direction) 
%       chooses the value automatically according to the Algorithm 1 (refer
%       to the assignment descripton).
%       direction = A string for specifying whether to look for
%       'horizontal' edges, 'vertical' edges, positive 45 degree 'pos45'
%       edges, negative 45 degree 'neg45' edges or 'all' edges.
%
%   For ALL submitted files in this assignment, 
%   you CANNOT use the following MATLAB functions:
%   edge, fspecial, imfilter, conv, conv2.
%
function g = myprewittedge(Im,T,direction)
[m,n]=size(Im);
PrewittNum=0;%The value of each pixel calculated by the Prewitt operator
PrewittThreshold=T;%set the threshold value
if isempty(PrewittThreshold) %if T is empty, choose the thresholding value caaroding to Algorith1
    PrewittThreshold=(max(max(Im))+min(min(Im)))/2;
    for i=1:10
        G1=Im.*(Im>=PrewittThreshold);
        G2=Im.*(Im<PrewittThreshold);
        m1=mean(mean(G1~=0));
        m2=mean(mean(G2~=0));
        PrewittThreshold=(m1+m2)/2;
    end
end

for j=2:m-1 %Perform boundary extraction, leaving 1 pixel of the edge
    for k=2:n-1
        PrewittNum=abs(Im(j-1,k+1)-Im(j+1,k+1)+Im(j-1,k)-Im(j+1,k)+Im(j-1,k-1)-Im(j+1,k-1))+abs(Im(j-1,k+1)+Im(j,k+1)+Im(j+1,k+1)-Im(j-1,k-1)-Im(j,k-1)-Im(j+1,k-1));
        if PrewittNum > PrewittThreshold
            newIm(j,k)=255;
        else
            newIm(j,k)=0;
        end
    end
end
g=newIm;