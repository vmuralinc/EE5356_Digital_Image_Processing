%IGF
clear all;
close all;
clc;

image_Lena = imread('Lena512.bmp');
image_Goldhill = imread('goldhill256.bmp');
image_Boat = imread('boat512.gif');
image_Girl = imread('Girl512.bmp');

sigma_Lena_sq = 15707;
sigma_Goldhill_sq = 28198;
sigma_Boat_sq = 41694;
sigma_Girl_sq = 34657;

fft_Lena = fft2(image_Lena);
fft_Goldhill = fft2(image_Goldhill);
fft_Boat = fft2(image_Boat);
fft_Girl = fft2(image_Girl);

N = 512;

IGF_Lena = zeros(N);
IGF_Boat = zeros(N);
IGF_Girl = zeros(N);

for i = 1:N
    for j = 1:N
        if (i <= N/2)
            if(j <= N/2)
                IGF_Lena(i,j) = exp((i^2 + j^2)/(2*sigma_Lena_sq));
                IGF_Boat(i,j) = exp((i^2 + j^2)/(2*sigma_Boat_sq));
                IGF_Girl(i,j) = exp((i^2 + j^2)/(2*sigma_Girl_sq));                
            else
                IGF_Lena(i,j) = IGF_Lena(i,N-j+1);
                IGF_Boat(i,j) = IGF_Boat(i,N-j+1);
                IGF_Girl(i,j) = IGF_Girl(i,N-j+1);
            end
        else
            if(j <= N/2)
                IGF_Lena(i,j) = IGF_Lena(N-i+1,j+1);
                IGF_Boat(i,j) = IGF_Boat(N-i+1,j+1);
                IGF_Girl(i,j) = IGF_Girl(N-i+1,j+1);
            else
                IGF_Lena(i,j) = IGF_Lena(N-i+1,N-j+1);
                IGF_Boat(i,j) = IGF_Boat(N-i+1,N-j+1);
                IGF_Girl(i,j) = IGF_Girl(N-i+1,N-j+1);
            end
        end
    end
end

N = 256;

IGF_Goldhill = zeros(N);

for i = 1:N
    for j = 1:N
        if (i <= N/2)
            if(j <= N/2)
                IGF_Goldhill(i,j) = exp((i^2 + j^2)/(2*sigma_Goldhill_sq));
            else
                IGF_Goldhill(i,j) = IGF_Goldhill(i,N-j+1);
            end
        else
            if(j <= N/2)
                IGF_Goldhill(i,j) = IGF_Goldhill(N-i+1,j+1);
            else
                IGF_Goldhill(i,j) = IGF_Goldhill(N-i+1,N-j+1);
            end
        end
    end
end

filter_Lena = IGF_Lena .* fft_Lena;
filter_Goldhill = IGF_Goldhill .* fft_Goldhill;
filter_Boat = IGF_Boat .* fft_Boat;
filter_Girl = IGF_Girl .* fft_Girl;

ifft_Lena = ifft2(filter_Lena);
ifft_Goldhill = ifft2(filter_Goldhill);
ifft_Boat = ifft2(filter_Boat);
ifft_Girl = ifft2(filter_Girl);

figure(1),surf( IGF_Lena, 'EdgeColor', 'none'); 
colormap(hsv);
shading interp;
alpha(0.7);
grid on;
axis tight;
title('IGF Lena');

figure(2)
subplot(1,2,1),imshow(image_Lena),title('original image');
subplot(1,2,2),imshow(uint8(ifft_Lena)),title('filtered image');

figure(3),surf( IGF_Goldhill, 'EdgeColor', 'none'); 
colormap(hsv);
shading interp;
alpha(0.7);
grid on;
axis tight;
title('IGF Goldhill');

figure(4)
subplot(1,2,1),imshow(image_Goldhill),title('original image');
subplot(1,2,2),imshow(uint8(ifft_Goldhill)),title('filtered image');

figure(5),surf( IGF_Boat, 'EdgeColor', 'none'); 
colormap(hsv);
shading interp;
alpha(0.7);
grid on;
axis tight;
title('IGF Boat');

figure(6)
subplot(1,2,1),imshow(image_Boat),title('original image');
subplot(1,2,2),imshow(uint8(ifft_Boat)),title('filtered image');

figure(7),surf( IGF_Girl, 'EdgeColor', 'none'); 
colormap(hsv);
shading interp;
alpha(0.7);
grid on;
axis tight;
title('IGF Girl');

figure(8)
subplot(1,2,1),imshow(image_Girl),title('original image');
subplot(1,2,2),imshow(uint8(ifft_Girl)),title('filtered image');