function overlap = cirlce_rect_overlap(r, cir, rect)
overlap = rect_rect_overlap([cir(:,1)-r cir(:,1)+r cir(:,2)-r cir(:,2)+r], rect);
end