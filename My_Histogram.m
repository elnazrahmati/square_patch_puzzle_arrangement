function RGB_output = My_Histogram (Input_Image) 
    input_dimension = size(Input_Image);
    RGB_output = (zeros(1, 256*3));
    for k = 1:3
        output_hist = uint32(zeros(1, 256));
        for i = 1 : input_dimension(1)
            for j = 1 : input_dimension(2)
                output_hist(Input_Image(i,j,k)+1) = output_hist(Input_Image(i,j,k)+1) + 1;
            end
        end
        RGB_output((k-1)*256+1:k*256) = output_hist;
    end
end