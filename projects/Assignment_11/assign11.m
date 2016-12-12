% SSIM 
clear all;
close all;
clc;

image1 = imread('Lena.gif');
image2 = imread('Lena4.gif');

L = 255;
K1 = 0.01;
K2 = 0.03;

C1 = (K1 * L)^2;
C2 = (K2 * L)^2;
C3 = C2/2;

alph = 1;
beta = 3;
gamma = 1;

[SSIM_metric SSIM_map] = my_ssim(image1,image2,alph,beta,gamma,C1,C2,C3);

imshow(real(SSIM_map));
disp(real(SSIM_metric));