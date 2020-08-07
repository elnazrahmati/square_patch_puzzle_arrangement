close all; clear; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%edit these variables before start 
path = 'E:\term6\machine vision\final_project\Puzzle_1_360\'; % folder address
format = '.tif'; % image format
number_of_patches = 360; % total number of patches
v = 0;% set if you want to see the process of makeing the puzzle
      % clear if you just want to see the final result
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = sqrt(number_of_patches/40);
width = 8*n; height = 5*n; patch_size = 240/n;
[acc,im] = puzzle_arrangement(path,format,width,height,patch_size,v);
figure,imshow(im);
title(['accuracy = ' num2str((acc+4)*100/number_of_patches) '%']);



