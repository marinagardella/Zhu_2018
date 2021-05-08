function [map] =analyze(img)
W = 32;
x = double(imread(img));
[x] = to_grayscale(x);
[mlv] = compute_mlv(double(x));
s = size(mlv);
nb_x_blocks = floor(s(1)/W);
nb_y_blocks = floor(s(2)/W);
noise_data = [];
mlv_data = [];
blocks_i = [];
blocks_j = [];
for i=0:(nb_x_blocks-1);
    for j= 0:(nb_y_blocks-1);
        block = x(i*W + 1 : (i+1)*W , j*W + 1 : (j+1)*W);
        [noise_block] = real(NoiseLevel(double(block)));
        mlv_block =  mean(mean(mlv(i*W + 1 : (i+1)*W , j*W + 1 : (j+1)*W)));
        mlv_data(end+1) = mlv_block;
        noise_data(end+1) = noise_block;
        blocks_i(end+1) = i;
        blocks_j(end+1) = j;
    end
end
f = fittype('a +b*x + c*x^2 + d*x^3 + e*x^4 + f*x^5');
[fit1,gof,fitinfo] = fit(mlv_data',noise_data',f,'StartPoint',[0 0 0 0 0 0]);
%plot(fit1,'r-',mlv_data,noise_data) 

map = zeros(size(x));
for k=1:length(blocks_i);
    bi = blocks_i(k);
    bj = blocks_j(k);
    b_noise = noise_data(k);
    b_mlv = mlv_data(k);
    dist = abs(b_noise - (fit1.a +fit1.b*b_mlv + fit1.c*b_mlv^2 + fit1.d*b_mlv^3 + fit1.e*b_mlv^4 + fit1.f*b_mlv^5));
    map(bi*W + 1 : (bi+1)*W , bj*W + 1 : (bj+1)*W) = dist;
end
%imwrite(map, 'map.png');
end %function


    