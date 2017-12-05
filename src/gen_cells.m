function [cells, perimeter, neighbors] = gen_cells(c, people, r, height, width, barriers)

%creating the cells
x = [0:c:width-c; c:c:width]';
y = [0:c:height-c; c:c:height]';
hc = height/c;
wc = width/c;
cell_rects = sortrows([sortrows(repmat(x,hc,1)) repmat(y,wc,1)]);

%getting the perimeter and indexing it
idx_perimeter = zeros(hc*wc,1);
corner_bl = 1;
corner_tl = hc;
corner_br = hc*(wc-1)+1;
corner_tr = hc*wc; 

side_l = 2:hc-1;
side_t = 2*hc:hc:hc*(wc - 1);
side_b = hc+1:hc:hc*(wc-2)+1;
side_r = hc*(wc-1)+2:hc*wc-1;

perimeter = [corner_bl corner_tl corner_br corner_tr ...
             side_l    side_t    side_b    side_r  ];
idx_perimeter(perimeter)=1;
idx_perimeter=logical(idx_perimeter);

%getting neighbors for each cell
neighbors = zeros(hc*wc, hc*wc);

cell_list = 1:hc*wc;
for i = cell_list(~idx_perimeter)
    neighbors(i,[i-hc-1:i-hc+1,i-1:i+1,i+hc-1:i+hc+1]) = 1;
end

for i = side_l
    neighbors(i,[i-1:i+1,i+hc-1:i+hc+1]) = 1;
end

for i = side_t
    neighbors(i,[i-hc-1:i-hc,i-1:i,i+hc-1:i+hc]) = 1;
end

for i = side_b
    neighbors(i,[i-hc:i-hc+1,i:i+1,i+hc:i+hc+1]) = 1;
end

for i = side_r
    neighbors(i,[i-hc-1:i-hc+1,i-1:i+1]) = 1;
end

i = corner_bl;
neighbors(i,[i:i+1,i+hc:i+hc+1]) = 1;
i = corner_tl;
neighbors(corner_tl,[i-1:i,i+hc-1:i+hc]) = 1;
i = corner_br;
neighbors(corner_br,[i-hc:i-hc+1,i:i+1]) = 1;
i = corner_tr;
neighbors(corner_tr,[i-hc-1:i-hc,i-1:i]) = 1;

neighbors=logical(neighbors);

cp = zeros(size(people,1), size(cell_rects,1));
cb = zeros(size(barriers,1), size(cell_rects,1));
for i=1:size(cell_rects,1)
    cp(:,i) = cirlce_rect_overlap(r, people, cell_rects(i,:));
    cb(:,i) = rect_line_overlap(cell_rects(i,:), barriers);
end
cp=logical(cp);
cb=logical(cb);

cells = struct('n', hc*wc, 'cells',cell_rects, 'neighbors', neighbors, ...
               'perimeter', idx_perimeter, 'people', cp, 'barriers', cb);
end