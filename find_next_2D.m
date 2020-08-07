function next_index = find_next_2D( x_hist_bank, x_LBP_bank,x_edge_bank, ...
    y_hist_bank, y_LBP_bank,y_edge_bank, x_t_hist, x_t_LBP,x_t_edge, y_t_hist, y_t_LBP,...
    y_t_edge, mark)
    
    x_t_edge = double(x_t_edge);
    y_t_edge = double(y_t_edge);
    dim = size(y_LBP_bank);
    norm1 = zeros(dim(1),1);
    m = mean(mean(x_hist_bank));
    s = std(std(x_hist_bank));
    x_hist_bank = (x_hist_bank - m)/s;
    x_t_hist = (x_t_hist - m)/s;
    m = mean(mean(y_hist_bank));
    s = std(std(y_hist_bank));
    y_hist_bank = (y_hist_bank - m)/s;
    y_t_hist = (y_t_hist - m)/s;
    m = mean(mean(x_LBP_bank));
    s = std(std(x_LBP_bank));
    x_LBP_bank = (x_LBP_bank - m)/s;
    x_t_LBP = (x_t_LBP - m)/s;
    m = mean(mean(y_LBP_bank));
    s = std(std(y_LBP_bank));
    y_LBP_bank = (y_LBP_bank - m)/s;
    y_t_LBP = (y_t_LBP - m)/s;
    m = mean(mean(x_edge_bank));
    s = std(std(x_edge_bank));
    x_edge_bank = (x_edge_bank - m)/s;
    x_t_edge = (x_t_edge - m)/s;
    m = mean(mean(y_edge_bank));
    s = std(std(y_edge_bank));
    y_edge_bank = (y_edge_bank - m)/s;
    y_t_edge = (y_t_edge - m)/s;
    for i = 1 : dim(1)
        norm1(i) = norm(double(x_hist_bank(i,:) - x_t_hist),1);
        norm1(i) = norm1(i) + norm(x_LBP_bank(i,:) - x_t_LBP,1);
        norm1(i) = norm1(i) + norm(x_edge_bank(i,:) - x_t_edge,1);
        norm1(i) = norm1(i) + norm(double(y_hist_bank(i,:) - y_t_hist),1);
        norm1(i) = norm1(i) + norm(y_LBP_bank(i,:) - y_t_LBP,1);
        norm1(i) = norm1(i) + norm(y_edge_bank(i,:) - y_t_edge,1);
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