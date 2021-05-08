function [G] = to_grayscale(img)
if size(img,3)==1;
    G = img;
else
    G = 0.299 .* img(:, :, 1) + 0.587 .* img(:, :, 2) + 0.114 .* img(:, :, 3);
end
end