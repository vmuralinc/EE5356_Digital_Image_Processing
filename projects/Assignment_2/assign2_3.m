clc
clear all;
%read image
iImage1 = imread('goldhill256.bmp');

% noise limit
A = 20;
% 3 bit quantizer level
L = 8;

% setting intervals
t = 0:256/L:256;
lenT = length(t);

% generating psuedorandom noise
noise = A .* ( -1 + (1-(-1)) .* rand(256,256));

% adding noise to image
iImage2 = double(iImage1) + noise;

% quantization
for i = 1:256
    for j = 1:256
        sample = double(iImage2(i,j));
        for k = 1:lenT-1
            if(sample >= t(k) && sample < t(k+1))
                iImage3(i,j) = (t(k) + t(k+1)) / 2;
            end
        end
    end
end

iImage4 = iImage3 - noise;

%MSE calculation
MSE = 0;

for i = 1:256
    for j = 1:256
        MSE = MSE + (double(iImage1(i,j)) - iImage4(i,j))^2;
    end
end

MSE = double(MSE / (256^2));

%PSNR calculation
PSNR = 10 * log10( 255^2 / MSE );

imshow(iImage1);

figure(2);
imshow(uint8(iImage4));