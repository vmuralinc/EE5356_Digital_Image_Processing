close all; 
clear all;
clc;

%Read the image
img = double(imread('cameraman.bmp'));
 
% Apply 2D-DFT to the input image
dft_img = fft2(img);
subplot(1,2,1);
imshow(img,[]);
title('Original image');
subplot(1,2,2);
imshow(uint8(real(dft_img)));
title('2D Fourier transform of the image');
 
[row col]=size(img);
H11 = zeros(row/2,col/2);
H12 = H11;
H13 = H11;
H14 = H11;
H21 = H11;
H22 = H11;
H23 = H11;
H24 = H11;
H31 = H11;
H32 = H11;
H33 = H11;
H34 = H11;

% k - constant that depends on the nature of the turbulence
K1 = 0.0025;
K2 = 0.001;
K3 = 0.00025;
 
% image Corruption by Atmospheric Turbulence
for i=1:1:row/2
    for j=1:1:col/2
        H11(i,j)=exp(-(K1*(i^2+j^2)^(5/6)));
        H12((row/2)+1-i,(col/2)+1-j)=H11(i,j);
        H13((row/2)+1-i,j)=H11(i,j);
        H14(i,(col/2)+1-j)=H11(i,j);
    end
end
for i=1:1:row/2
    for j=1:1:col/2
        H21(i,j)=exp(-(K2*(i^2+j^2)^(5/6)));
        H22((row/2)+1-i,(col/2)+1-j)=H21(i,j);
        H23((row/2)+1-i,j)=H21(i,j);
        H24(i,(col/2)+1-j)=H21(i,j);
    end
end
for i=1:1:row/2
    for j=1:1:col/2
        H31(i,j)=exp(-(K3*(i^2+j^2)^(5/6)));
        H32((row/2)+1-i,(col/2)+1-j)=H31(i,j);
        H33((row/2)+1-i,j)=H31(i,j);
        H34(i,(col/2)+1-j)=H31(i,j);
    end
end
H1=zeros(row,col);
H1((1:row/2),(1:col/2))=H11;
H1((row/2)+1:row,(col/2)+1:col)=H12;
H1((row/2)+1:row,1:(col/2))=H13;        
H1((1:(row/2)),(col/2)+1:col)=H14;
H2=zeros(row,col);
H2((1:row/2),(1:col/2))=H21;
H2((row/2)+1:row,(col/2)+1:col)=H22;
H2((row/2)+1:row,1:(col/2))=H23;        
H2((1:(row/2)),(col/2)+1:col)=H24;
H3=zeros(row,col);
H3((1:row/2),(1:col/2))=H31;
H3((row/2)+1:row,(col/2)+1:col)=H32;
H3((row/2)+1:row,1:(col/2))=H33;        
H3((1:(row/2)),(col/2)+1:col)=H34;
 
% Plots
figure;
subplot(2,2,1);
imshow(H1,[]);
title('Degradation function for k = 0.0025');
subplot(2,2,2);
imshow(H2,[]);
title('Degradation function for k = 0.001');
subplot(2,2,3);
imshow(H3,[]);
title('Degradation function for k = 0.00025');

 
% Filtered img
filt_dft_img1 = ifft2((dft_img).*H1);
filt_dft_img2 = ifft2((dft_img).*H2);
filt_dft_img3 = ifft2((dft_img).*H3);
 
figure;
subplot(2,2,1);
imshow(img,[]);
title('Original image');
subplot(2,2,2);
imshow(uint8(real(filt_dft_img1)));
title('Filtered image with k = 0.0025');
subplot(2,2,3);
imshow(uint8(real(filt_dft_img2)));
title('Filtered image with k = 0.001');
subplot(2,2,4);
imshow(uint8(real(filt_dft_img3)));
title('Filtered image with k = 0.00025');