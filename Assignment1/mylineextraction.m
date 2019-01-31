function [bp, ep] = mylineextraction(BW)
%   The function extracts the longest line segment from the given binary image
%       Input parameter:
%       BW = A binary image.
%
%       Output parameters:
%       [bp, ep] = beginning and end points of the longest line found
%       in the image.
%
%   You may need the following predefined MATLAB functions: hough,
%   houghpeaks, houghlines.
[n,m]=size(BW);
[H,theta,rho] = hough(BW);%Hough transform
peaks = houghpeaks(H, 5);%find 5 peaks of hough transforms
lines = houghlines(BW, theta, rho, peaks);%Find the endpoints of the 5 longest segments
temp=length(lines);
maxlength=0;
for i=1:temp %find the longest segment
    xy=[lines(i).point1;lines(i).point2];
    if  ((xy(1,1)-xy(2,1))^2+(xy(1,2)-xy(2,2))^2)>maxlength
        maxlength=((xy(1,1)-xy(2,1))^2+(xy(1,2)-xy(2,2))^2);
        bp=xy(1,:);
        ep=xy(2,:);
    end
end