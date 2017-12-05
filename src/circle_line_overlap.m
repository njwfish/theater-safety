function overlap = circle_line_overlap(r, cir, lines)
%return true if cricle of interest overlaps any rectangles in list
overlap = rect_line_overlap([cir(1)-r cir(1)+r cir(2)-r cir(2)+r], lines);
if all(~overlap)
    return
end
ax = lines(:,1) - cir(1);
ay = lines(:,3) - cir(2);
bx = lines(:,2) - cir(1);
by = lines(:,4) - cir(2);
dx = ax - bx;
dy = ay - by;
overlap = (r^2 * (dx.^2 + dy.^2) - (ax.*by - bx.*ay).^2 >= 0) & overlap;
end