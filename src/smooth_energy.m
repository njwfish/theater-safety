function en_s = smooth_energy(en_h)
en_s=en_h;
for i = 1:size(en_s,2)-1
    dU = en_s(i+1)-en_s(i);
    if dU > 0
        en_s(i+1:end) = en_s(i+1:end)-dU;
    end
end
end