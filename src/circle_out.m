function out = circle_out(r, cir, height, width)
%return true if circle of interest out of bounds of rect with right bottom
%at zero
out = (cir(:,1)-r < 0 | cir(:,1) + r > width | cir(:,2) - r < 0 | cir(:,2) + r > height);
end