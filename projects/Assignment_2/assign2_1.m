clc

clear all;

%read image
iImage1 = imread('goldhill256.bmp');

[row col] = size(iImage1);

% quantization level
L = 32;

% determining limits
t = 0:256/L:256;

% quantization
for i = 1:row
    for j = 1:col
        for k = 1:L
            if(iImage1(i,j)>=t(k) && iImage1(i,j) < t(k+1))
                iImage2(i,j) = (t(k) + t(k+1))/2;
            end
        end
    end
end

%MSE calculation
MSE = 0;

for i = 1:256
    for j = 1:256
        MSE = MSE + (double(iImage1(i,j)) - iImage2(i,j))^2;
    end
end

MSE = double(MSE / (256^2));

%PSNR calculation
PSNR = 10 * log10( 255^2 / MSE );

imshow(iImage1);

figure(2);
imshow(uint8(iImage2));