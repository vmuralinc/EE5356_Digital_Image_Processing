% Universal Image Quality Index
clear all;
close all;
clc;

lena = double(imread('Lena.gif'));
subplot(2,4,1);imshow(uint8(lena));title('Original Image');
image1 = double(imread('Lena1.gif'));
subplot(2,4,2);imshow(uint8(image1));title('Image 1 - Salt Pepper noise');
image2 = double(imread('Lena2.gif'));
subplot(2,4,3);imshow(uint8(image2));title('Image 2 - Gaussian noise');
image3 = double(imread('Lena3.gif'));
subplot(2,4,4);imshow(uint8(image3));title('Image 3 - Speckle');
image4 = double(imread('Lena4.gif'));
subplot(2,4,4);imshow(uint8(image4));title('Image 4 - Mean shift');
image5 = double(imread('Lena5.gif'));
subplot(2,4,5);imshow(uint8(image5));title('Image 5 - Contrast Stretching');
image6 = double(imread('Lena6.gif'));
subplot(2,4,6);imshow(uint8(image6));title('Image 6 - Blurred Image');
image7 = double(imread('Lena7.gif'));
subplot(2,4,7);imshow(uint8(image7));title('Image 7 - Compressed Image');

L = 255;
K1 = 0.01;
K2 = 0.03;

C1 = (K1 * L)^2;
C2 = (K2 * L)^2;
C3 = C2/2;

alph = 1;
beta = 1;
gamma = 1;

[SSIM_metric0 SSIM_map0] = my_ssim(lena,lena,alph,beta,gamma,C1,C2,C3);
[SSIM_metric1 SSIM_map1] = my_ssim(lena,image1,alph,beta,gamma,C1,C2,C3);
[SSIM_metric2 SSIM_map2] = my_ssim(lena,image2,alph,beta,gamma,C1,C2,C3);
[SSIM_metric3 SSIM_map3] = my_ssim(lena,image3,alph,beta,gamma,C1,C2,C3);
[SSIM_metric4 SSIM_map4] = my_ssim(lena,image4,alph,beta,gamma,C1,C2,C3);
[SSIM_metric5 SSIM_map5] = my_ssim(lena,image5,alph,beta,gamma,C1,C2,C3);
[SSIM_metric6 SSIM_map6] = my_ssim(lena,image6,alph,beta,gamma,C1,C2,C3);
[SSIM_metric7 SSIM_map7] = my_ssim(lena,image7,alph,beta,gamma,C1,C2,C3);

b_size = 8;
[UIQI_metric0 UIQI_map0] = my_uiqi(lena,lena,b_size);
[UIQI_metric1 UIQI_map1] = my_uiqi(lena,image1,b_size);
[UIQI_metric2 UIQI_map2] = my_uiqi(lena,image2,b_size);
[UIQI_metric3 UIQI_map3] = my_uiqi(lena,image3,b_size);
[UIQI_metric4 UIQI_map4] = my_uiqi(lena,image4,b_size);
[UIQI_metric5 UIQI_map5] = my_uiqi(lena,image5,b_size);
[UIQI_metric6 UIQI_map6] = my_uiqi(lena,image6,b_size);
[UIQI_metric7 UIQI_map7] = my_uiqi(lena,image7,b_size);