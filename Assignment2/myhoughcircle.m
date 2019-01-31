function [y0detect,x0detect,Accumulator] = houghcircle(Imbinary,r,thresh)
%HOUGHCIRCLE - detects circles with specific radius in a binary image.
%
%Comments:
%       Function uses Standard Hough Transform to detect circles in a binary image.
%       According to the Hough Transform for circles, each pixel in image space
%       corresponds to a circle in Hough space and vice versa. 
%       upper left corner of image is the origin of coordinate system.
%
%Usage: [y0detect,x0detect,Accumulator] = houghcircle(Imbinary,r,thresh)
%
%Arguments:
%       Imbinary - a binary image. image pixels that have value equal to 1 are
%                  interested pixels for HOUGHLINE function.
%       r        - radius of circles.
%       thresh   - a threshold value that determines the minimum number of
%                  pixels that belong to a circle in image space. threshold must be
%                  bigger than or equal to 4(default).
%
%Returns:
%       y0detect    - row coordinates of detected circles.
%       x0detect    - column coordinates of detected circles. 
%       Accumulator - the accumulator array in Hough space.

if nargin == 2
    thresh = 4;
elseif thresh < 4
    error('threshold value must be bigger or equal to 4');
    return
end

%Voting


% Finding local maxima in Accumulator

[h,w]=size(Imbinary);

%hough±ä»»
Accumulator=zeros(h,w);
for x=1:w
    for y=1:h
        if(Imbinary(y,x))
            for theta=linspace(0,2*pi,360)
                a=round(x+r*cos(theta));
                b=round(y+r*sin(theta));
                if(a>0 && a<=w &&b>0 && b<=h)
                    Accumulator(b,a)=Accumulator(b,a)+1;
                end
            end
        end
    end
end

temp_centers = houghpeaks(Accumulator, 1, 'Threshold', thresh);
y0detect=temp_centers(1);
x0detect=temp_centers(2);



end






