function overlap = rect_line_overlap(rect, lines)
overlap = ~((lines(:,1) > rect(2) & lines(:,2) > rect(2)) | (lines(:,1) < rect(1) & lines(:,2) < rect(1)) | (lines(:,3) > rect(4) & lines(:,4) > rect(4)) | (lines(:,3) < rect(3) & lines(:,4) < rect(3)));
if all(~overlap)
    return
end
det = lines(:,2) .* lines(:,3) - lines(:,1) .* lines(:,4);
dy = lines(:,4) - lines(:,3);
dx = lines(:,1) - lines(:,2);
overlap = any((dy.*rect(1:2) + dx.*rect(3:4) + det > 0 | dy.*rect(1:2) + dx.*rect(3:4) + det < 0) & overlap,2);
end