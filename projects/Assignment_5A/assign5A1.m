clear all;
close all;
clc;

disp(sprintf('menu\n1.Lena\n2.Goldhill\n3.Boat\n4.Girl\n'));
choice = input('Enter choice: ');
if(choice == 1)
    image = imread('Lena512.bmp');
    sigma_sq = 15707;
elseif(choice == 2)
    image = imread('goldhill256.bmp');
    sigma_sq = 28198;
elseif(choice == 3)
    image = imread('boat512.gif');
    sigma_sq = 41694;
else
    image = imread('Girl512.bmp');
    sigma_sq = 34657;
end

fftImage = fft2(image);

[row col] = size(image);

IGF = zeros(row,col);

for i = 1:row
    for j = 1:col
        if (i <= row/2)
            if(j <= col/2)
                IGF(i,j) = exp((i^2 + j^2)/(2*sigma_sq));
            else
                IGF(i,j) = IGF(i,col-j+1);
            end
        else
            if(j <= col/2)
                IGF(i,j) = IGF(row-i+1,j+1);
            else
                IGF(i,j) = IGF(row-i+1,col-j+1);
            end
        end
    end
end

filtImage = IGF.*fftImage;
ifftImage = ifft2(filtImage);

subplot(1,2,1),imshow(image),title('original image');
subplot(1,2,2),imshow(uint8(abs(ifftImage))),title('filtered image');

figure, surf( IGF, 'EdgeColor', 'none'); 
colormap(hsv);
shading interp;
alpha(0.7);
grid on;
axis tight;
title('IGF');