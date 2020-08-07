function [mark, mat] = make_patch(direction, x_hist_bank, x_LBP_bank,x_edge_bank, ...
    y_hist_bank, y_LBP_bank,y_edge_bank, bank_path, corner_path, mark, mat, width, height, s)
    
    w = floor(width/2);
    h = floor(height/2);
    
    curr = corner_path;
    corner1 = imread(curr);
    switch direction
        case 'lu'
            if height/2 - floor(height/2) ~= 0
               h = h + 1; 
            end
            for i = 2:w
                r_hist_corner = My_Histogram(corner1(:,s-3:s,:));
                r_LBP_corner = extractLBPFeatures(rgb2gray(corner1(:,s-3:s,:)));
                r_edge_corner = reshape(corner1(:,s,:),1,s*3);
                next_index = find_next(x_hist_bank, x_LBP_bank,x_edge_bank, ...
                    r_hist_corner, r_LBP_corner,r_edge_corner, mark);
                mark(next_index) = 0;
                mat(1,i) = next_index;
                curr = [bank_path num2str(next_index) '.tif'];
                corner1 = imread(curr);
            end
            curr = corner_path;
            corner1 = imread(curr);
            for i = 2:h
                d_hist_corner = My_Histogram(corner1(s-3:s,:,:));
                d_LBP_corner = extractLBPFeatures(rgb2gray(corner1(s-3:s,:,:)));
                d_edge_corner = reshape(corner1(s,:,:),1,s*3);
                next_index = find_next(y_hist_bank, y_LBP_bank,y_edge_bank, ...
                d_hist_corner, d_LBP_corner,d_edge_corner, mark);
                mark(next_index) = 0;
                mat(i,1) = next_index;
                curr = [bank_path num2str(next_index) '.tif'];
                corner1 = imread(curr);
            end
            for i = 2:h
               for j = 2:w
                  x_t_path = [bank_path num2str(mat(i,j-1)) '.tif'];
                  y_t_path = [bank_path num2str(mat(i-1,j)) '.tif'];
                  corner1 = imread(x_t_path);
                  x_t_hist = My_Histogram(corner1(:,s-3:s,:));
                  x_t_LBP = extractLBPFeatures(rgb2gray(corner1(:,s-3:s,:)));
                  x_t_edge = reshape(corner1(:,s,:),1,s*3);
                  corner1 = imread(y_t_path);
                  y_t_hist = My_Histogram(corner1(s-3:s,:,:));
                  y_t_LBP = extractLBPFeatures(rgb2gray(corner1(s-3:s,:,:)));
                  y_t_edge = reshape(corner1(s,:,:),1,s*3);
                  next_index = find_next_2D(x_hist_bank, x_LBP_bank, ...
                    x_edge_bank,y_hist_bank, y_LBP_bank,y_edge_bank,...
                    x_t_hist, x_t_LBP,x_t_edge,y_t_hist, y_t_LBP,y_t_edge, mark); 
                mark(next_index) = 0;
                mat(i,j) = next_index;
               end
            end
            
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
        case 'ld'
            for i = 2:w
                r_hist_corner = My_Histogram(corner1(:,s-3:s,:));
                r_LBP_corner = extractLBPFeatures(rgb2gray(corner1(:,s-3:s,:)));
                r_edge_corner = reshape(corner1(:,s,:),1,s*3);
                next_index = find_next(x_hist_bank, x_LBP_bank,x_edge_bank, ...
                r_hist_corner, r_LBP_corner,r_edge_corner, mark);
                mark(next_index) = 0;
                mat(height,i) = next_index;
                curr = [bank_path num2str(next_index) '.tif'];
                corner1 = imread(curr);
            end
            curr = corner_path;
            corner1 = imread(curr);
            for i = height-1:-1:height - h + 1
                u_hist_corner = My_Histogram(corner1(1:3,:,:));
                u_LBP_corner = extractLBPFeatures(rgb2gray(corner1(1:3,:,:)));
                u_edge_corner = reshape(corner1(1,:,:),1,s*3);
                next_index = find_next(y_hist_bank, y_LBP_bank,y_edge_bank, ...
                u_hist_corner, u_LBP_corner,u_edge_corner, mark);
                mark(next_index) = 0;
                mat(i,1) = next_index;
                curr = [bank_path num2str(next_index) '.tif'];
                corner1 = imread(curr);
            end
            for i = height-1:-1:height - h + 1
               for j = 2:w
                  x_t_path = [bank_path num2str(mat(i,j-1)) '.tif'];
                  y_t_path = [bank_path num2str(mat(i+1,j)) '.tif'];
                  corner1 = imread(x_t_path);
                  x_t_hist = My_Histogram(corner1(:,s-3:s,:));
                  x_t_LBP = extractLBPFeatures(rgb2gray(corner1(:,s-3:s,:)));
                  x_t_edge = reshape(corner1(:,s,:),1,s*3);
                  corner1 = imread(y_t_path);
                  y_t_hist = My_Histogram(corner1(1:3,:,:));
                  y_t_LBP = extractLBPFeatures(rgb2gray(corner1(1:3,:,:)));
                  y_t_edge = reshape(corner1(1,:,:),1,s*3);
                  next_index = find_next_2D(x_hist_bank, x_LBP_bank, ...
                    x_edge_bank,y_hist_bank, y_LBP_bank,y_edge_bank,...
                    x_t_hist, x_t_LBP,x_t_edge,y_t_hist, y_t_LBP,y_t_edge, mark); 
                mark(next_index) = 0;
                mat(i,j) = next_index;
               end
            end
            
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
        case 'ru'
            if height/2 - floor(height/2) ~= 0
               h = h + 1; 
            end
            for i = width-1:-1:width-w+1
                l_hist_corner = My_Histogram(corner1(:,1:3,:));
                l_LBP_corner = extractLBPFeatures(rgb2gray(corner1(:,1:3,:)));
                l_edge_corner = reshape(corner1(:,1,:),1,s*3);
                next_index = find_next(x_hist_bank, x_LBP_bank,x_edge_bank, ...
                l_hist_corner, l_LBP_corner,l_edge_corner, mark);
                mark(next_index) = 0;
                mat(1,i) = next_index;
                curr = [bank_path num2str(next_index) '.tif'];
                corner1 = imread(curr);
            end
            curr = corner_path;
            corner1 = imread(curr);
            for i = 2:h
                d_hist_corner = My_Histogram(corner1(s-3:s,:,:));
                d_LBP_corner = extractLBPFeatures(rgb2gray(corner1(s-3:s,:,:)));
                d_edge_corner = reshape(corner1(s,:,:),1,s*3);
                next_index = find_next(y_hist_bank, y_LBP_bank,y_edge_bank, ...
                d_hist_corner, d_LBP_corner,d_edge_corner, mark);
                mark(next_index) = 0;
                mat(i,width) = next_index;
                curr = [bank_path num2str(next_index) '.tif'];
                corner1 = imread(curr);
            end
            for i = 2:h
               for j = width-1:-1:width-w+1
                  x_t_path = [bank_path num2str(mat(i,j+1)) '.tif'];
                  y_t_path = [bank_path num2str(mat(i-1,j)) '.tif'];
                  corner1 = imread(x_t_path);
                  x_t_hist = My_Histogram(corner1(:,1:3,:));
                  x_t_LBP = extractLBPFeatures(rgb2gray(corner1(:,1:3,:)));
                  x_t_edge  = reshape(corner1(:,1,:),1,s*3);
                  corner1 = imread(y_t_path);
                  y_t_hist = My_Histogram(corner1(s-3:s,:,:));
                  y_t_LBP = extractLBPFeatures(rgb2gray(corner1(s-3:s,:,:)));
                  y_t_edge = reshape(corner1(s,:,:),1,s*3);
                  next_index = find_next_2D(x_hist_bank, x_LBP_bank, ...
                    x_edge_bank,y_hist_bank, y_LBP_bank,y_edge_bank,...
                    x_t_hist, x_t_LBP,x_t_edge,y_t_hist, y_t_LBP,y_t_edge, mark); 
                mark(next_index) = 0;
                mat(i,j) = next_index;
               end
            end
            
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        case 'rd'
            for i = width-1:-1:width-w+1
                l_hist_corner = My_Histogram(corner1(:,1:3,:));
                l_LBP_corner = extractLBPFeatures(rgb2gray(corner1(:,1:3,:)));
                l_edge_corner = reshape(corner1(:,1,:),1,s*3);
                next_index = find_next(x_hist_bank, x_LBP_bank,x_edge_bank, ...
                l_hist_corner, l_LBP_corner,l_edge_corner, mark);
                mark(next_index) = 0;
                mat(height,i) = next_index;
                curr = [bank_path num2str(next_index) '.tif'];
                corner1 = imread(curr);
            end
            curr = corner_path;
            corner1 = imread(curr);
            for i = height-1:-1:height-h+1
                u_hist_corner = My_Histogram(corner1(1:3,:,:));
                u_LBP_corner = extractLBPFeatures(rgb2gray(corner1(1:3,:,:)));
                u_edge_corner = reshape(corner1(1,:,:),1,s*3);
                next_index = find_next(y_hist_bank, y_LBP_bank,y_edge_bank, ...
                u_hist_corner, u_LBP_corner,u_edge_corner, mark);
                mark(next_index) = 0;
                mat(i,width) = next_index;
                curr = [bank_path num2str(next_index) '.tif'];
                corner1 = imread(curr);
            end
            for i = height-1:-1:height-h+1
               for j = width-1:-1:width-w+1
                  x_t_path = [bank_path num2str(mat(i,j+1)) '.tif'];
                  y_t_path = [bank_path num2str(mat(i+1,j)) '.tif'];
                  corner1 = imread(x_t_path);
                  x_t_hist = My_Histogram(corner1(:,1:3,:));
                  x_t_LBP = extractLBPFeatures(rgb2gray(corner1(:,1:3,:)));
                  x_t_edge = reshape(corner1(:,1,:),1,s*3);
                  corner1 = imread(y_t_path);
                  y_t_hist = My_Histogram(corner1(1:3,:,:));
                  y_t_LBP = extractLBPFeatures(rgb2gray(corner1(1:3,:,:)));
                  y_t_edge = reshape(corner1(1,:,:),1,s*3);
                  next_index = find_next_2D(x_hist_bank, x_LBP_bank, ...
                    x_edge_bank,y_hist_bank, y_LBP_bank,y_edge_bank,...
                    x_t_hist, x_t_LBP,x_t_edge,y_t_hist, y_t_LBP,y_t_edge, mark); 
                mark(next_index) = 0;
                mat(i,j) = next_index;
               end
            end
            
            
    end
    

end