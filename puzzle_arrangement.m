function [acc,im] = puzzle_arrangement(path,format,width,height,patch_size,verbose)
    acc = 0;
    l_feature_hist = (zeros(width*height-4, 256*3));
    l_feature_edge = zeros(width*height-4, patch_size*3);
    l_feature_LBP = zeros(width*height-4, 59);
    r_feature_hist = (zeros(width*height-4, 256*3));
    r_feature_edge = zeros(width*height-4, patch_size*3);
    r_feature_LBP = zeros(width*height-4, 59);
    u_feature_hist = (zeros(width*height-4, 256*3));
    u_feature_edge = zeros(width*height-4, patch_size*3);
    u_feature_LBP = zeros(width*height-4, 59);
    d_feature_hist = (zeros(width*height-4, 256*3));
    d_feature_edge = zeros(width*height-4, patch_size*3);
    d_feature_LBP = zeros(width*height-4, 59);
    for i = 1 : width*height-4
       I = imread([path 'Patch_' num2str(i) format]);
       l_feature_hist(i,:) = My_Histogram(I(:,1:3,:));
       l_feature_edge(i,:) = reshape(I(:,1,:),1,patch_size*3);
       l_feature_LBP(i,:) = extractLBPFeatures(rgb2gray(I(:,1:3,:)));
       %%%%%%%%%%%%%%%%%%%%%%%%%
       r_feature_hist(i,:) = My_Histogram(I(:,patch_size-3:patch_size,:));
       r_feature_edge(i,:) = reshape(I(:,patch_size,:),1,patch_size*3);
       r_feature_LBP(i,:) = extractLBPFeatures(rgb2gray(I(:,patch_size-3:patch_size,:)));
       %%%%%%%%%%%%%%%%%%%%%%%%%
       u_feature_hist(i,:) = My_Histogram(I(1:3,:,:));
       u_feature_edge(i,:) = reshape(I(1,:,:),1,patch_size*3);
       u_feature_LBP(i,:) = extractLBPFeatures(rgb2gray(I(1:3,:,:)));
       %%%%%%%%%%%%%%%%%%%%%%%%%
       d_feature_hist(i,:) = My_Histogram(I(patch_size-3:patch_size,:,:));
       d_feature_edge(i,:) = reshape(I(patch_size,:,:),1,patch_size*3);
       d_feature_LBP(i,:) = extractLBPFeatures(rgb2gray(I(patch_size-3:patch_size,:,:)));
    end

    mark = ones(width*height-4,1);
    mat = zeros(height,width);
    corner_path = [path 'Corner_1_1.tif'];
    [mark, mat] = make_patch('lu', l_feature_hist, l_feature_LBP,l_feature_edge, ...
        u_feature_hist, u_feature_LBP,u_feature_edge, [path 'Patch_'],...
        corner_path, mark,mat, width, height, patch_size);

    corner_path = [path 'Corner_1_' num2str(width) '.tif'];
    [mark, mat] = make_patch('ru', r_feature_hist,  r_feature_LBP,r_feature_edge, ...
        u_feature_hist, u_feature_LBP,u_feature_edge, [path 'Patch_'],...
        corner_path, mark,mat, width, height, patch_size);

    corner_path = [path 'Corner_' num2str(height) '_' num2str(width) '.tif'];
    [mark, mat] = make_patch('rd', r_feature_hist, r_feature_LBP,r_feature_edge, ...
        d_feature_hist, d_feature_LBP,d_feature_edge, [path 'Patch_'],...
        corner_path, mark,mat, width, height, patch_size);


    corner_path = [path 'Corner_' num2str(height) '_1.tif'];
    [~, mat] = make_patch('ld', l_feature_hist, l_feature_LBP,l_feature_edge, ...
        d_feature_hist, d_feature_LBP,d_feature_edge, [path 'Patch_'],...
        corner_path, mark,mat, width, height, patch_size);

    I = imread([path 'Original.tif']);
    for i = 1:height
        if i==1
            im1 = imread([path 'Corner_1_1.tif']);
        elseif i == height
            im1 = imread([path 'Corner_' num2str(height) '_1.tif']);
        else
            im1 = imread([path 'Patch_' num2str(mat(i,1)) '.tif']);
            if sum(sum(sum(I((i-1)*patch_size+1:i*patch_size,1:patch_size,:) - im1))) == 0
               acc = acc + 1; 
            end
        end
        if verbose
            subplot(10,1,10);
            imshow(im1);
            pause(0.3);
        end
        for j = 2:width
            if j == width && i==1
                J = imread([path 'Corner_1_' num2str(width) '.tif']);
            elseif j == width && i==height
                J = imread([path 'Corner_' num2str(height) '_' num2str(width) '.tif']);
            else
                J = imread([path 'Patch_' num2str(mat(i,j)) '.tif']);
                if sum(sum(sum(I((i-1)*patch_size+1:i*patch_size,...
                        (j-1)*patch_size+1:j*patch_size,:) - J))) == 0
                   acc = acc + 1; 
                end
            end
            
            im1 = horzcat(im1,J);
            if verbose
                subplot(10,1,10);
                imshow(im1);
                pause(0.3);
            end
        end
        if i == 1
            im = im1;
        else
            im = vertcat(im, im1);
        end
        if verbose
            subplot(10,1,[1,9]);
            imshow(im);
        end
    end
end
