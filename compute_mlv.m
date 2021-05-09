function [mlv] = compute_mlv(img)
img(:)=img(:)/255; 
[xs, ys] = size(img);
x=img;

x1=zeros(xs,ys);
x2=zeros(xs,ys);
x3=zeros(xs,ys);
x4=zeros(xs,ys);
x5=zeros(xs,ys);
x6=zeros(xs,ys);
x7=zeros(xs,ys);
x8=zeros(xs,ys);

x1(1:xs-1,:) = abs(x(1:xs-1,:)-x(2:xs, :));
x2(2:xs, :) = abs(x(2:xs, :) - x(1:xs-1, :));
x3(:, 1:ys-1) = abs(x(:, 1:ys-1) - x(:, 2:ys));
x4(:, 2:ys) = abs(x(:, 2:ys) - x(:, 1:ys-1));
x5(2:xs, 2:ys) = abs(x(2:xs, 2:ys) - x(1:xs-1, 1:ys-1));
x6(2:xs, 1:ys-1) = abs(x(2:xs,1:ys-1) - x(1:xs-1, 2:ys));
x7(1:xs-1, 1:ys-1) = abs(x(1:xs-1,1:ys-1) - x(2:xs, 2:ys));
x8(1:xs-1, 2:ys) = abs(x(1:xs-1,2:ys) - x(2:xs,  1:ys-1));
    
mlv=max(x1,x2);
mlv=max(mlv,x3);
mlv=max(mlv,x4);
mlv=max(mlv,x5);
mlv=max(mlv,x6);
mlv=max(mlv,x7);
mlv=max(mlv,x8);

ranks = rank_with_duplicates(mlv(:));
ranks = ranks + (-1);
ranks = ranks/(length(ranks));
weighted_ranks = exp(ranks);
weighted_ranks = reshape(weighted_ranks, size(mlv));

mlv = mlv.*weighted_ranks;

% for k=1:length(sorted_values);
%     value = sorted_values(k);
%     weight = weights(k);
%     mlv(find(mlv==value)) = value*weight;
% end
end % function





