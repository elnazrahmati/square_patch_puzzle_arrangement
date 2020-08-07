function next_index = find_next(hist_bank, LBP_bank, edge_bank, ...
    t_hist, t_LBP,t_edge, mark)
    
    t_edge = double(t_edge);
    dim = size(hist_bank);
    norm1 = zeros(dim(1),1);
    m = mean(mean(hist_bank));
    s = std(std(hist_bank));
    hist_bank = (hist_bank - m)/s;
    t_hist = (t_hist - m)/s;
    m = mean(mean(LBP_bank));
    s = std(std(LBP_bank));
    LBP_bank = (LBP_bank - m)/s;
    t_LBP = (t_LBP - m)/s;
    m = mean(mean(edge_bank));
    s = std(std(edge_bank));
    edge_bank = (edge_bank - m)/s;
    t_edge = (t_edge - m)/s;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1 : dim(1)
        norm1(i) = norm(double(hist_bank(i,:) - t_hist),1);
        norm1(i) = norm1(i) + norm(norm(edge_bank(i,:) - t_edge,1));
        norm1(i) = norm1(i) + norm(LBP_bank(i,:) - t_LBP,1);
    end
    sorted_norm1 = sort(norm1);
    for i = 1 : dim(1)
        [~, min_index] = max((norm1 == sorted_norm1(i)));
        if mark(min_index) == 1
            next_index = min_index;
            break;
        end
    end
end