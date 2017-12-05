function exits = map_exits(e, fraction_exits, height, width)
%Takes e, a vector of real numbners between 0 and 1, and creates a matrix
%of partitions of length fraction_exits/|e|. This represents the exits, on
%the real interval between zero and one. This is then mapped each to the
%perimeter of the rectangle with the given height and width.

exit_size =  fraction_exits / length(e);
e = (1 - exit_size) * e;
partitions = [e; e+exit_size]';

perimeter = 2 * width + 2 * height;
partitions = partitions * perimeter;

exits = [];

for i = partitions'
    if i(1) < height
        if i(2) < height
            exits = [exits; 0.1 0.1 i(1) i(2)];
        else
            exits = [exits; 0.1 0.1 i(1) height; 0 i(2)-height height-0.1 height-0.1];
        end
    elseif i(1) < height + width
        if i(2) < height + width
            exits = [exits; i(1)-height i(2)-height height-0.1 height-0.1];
        else
            exits = [exits; i(1)-height width height-0.1 height-0.1; width-0.1 width-0.1 height height-(i(2)-height-width)];
        end
    elseif i(1) < 2 * height + width
        if i(2) < 2 * height + width
            exits = [exits; width-0.1 width-0.1 height-(i(1)-height-width) height-(i(2)-height-width)];
        else
            exits = [exits; width-0.1 width-0.1 height-(i(1)-height-width) 0; width width-(i(2)-2*height-width) 0.1 0.1];
        end
    else
        exits = [exits; width-(i(1)-2*height-width) width-(i(2)-2*height-width) 0.1 0.1];
    end

end