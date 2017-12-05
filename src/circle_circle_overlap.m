function overlap = circle_circle_overlap(r, cir, cir_list)
%return true if cricle of interest overlaps any circles in list
%add rectangle overlap calc if faster
overlap = abs(cir(1) - cir_list(:,1)).^2 + abs(cir(2) - cir_list(:,2)).^2 < 4*r^2;
end