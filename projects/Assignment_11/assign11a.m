clear all;
close all;
clc;
lena = double(imread('Lena.gif'));
subplot(2,4,1);imshow(uint8(lena));title('Test Image');
image1 = double(imread('Lena1.gif'));
subplot(2,4,2);imshow(uint8(image1));title('Image 1 - Salt Pepper noise');
image2 = double(imread('Lena4.gif'));
subplot(2,4,3);imshow(uint8(image2));title('Image 2 - Mean shift');
image3 = double(imread('Lena3.gif'));
subplot(2,4,4);imshow(uint8(image3));title('Image 3 - Speckle');
image4 = double(imread('Lena2.gif'));
subplot(2,4,5);imshow(uint8(image4));title('Image 4 - Gaussian noise');
image5 = double(imread('Lena6.gif'));
subplot(2,4,6);imshow(uint8(image5));title('Image 5 - Blurred Image');
image6 = double(imread('Lena7.gif'));
subplot(2,4,7);imshow(uint8(image6));title('Image 6 - Compressed Image');
image7 = double(imread('Lena5.gif'));
subplot(2,4,8);imshow(uint8(image7));title('Image 7 - Contrast Stretching');



%%%%%%%%%% Weight for Task 1 %%%%%%%%%%%%%
%w = [0.0448 0.2856 0.3001 0.2363 0.1333];


%%%%%%%%%% Weight for Task 2 %%%%%%%%%%%%%
w = [0.0619 0.1337 0.2254 0.3536 0.2254];

for i = 1:5
    mssim1(i) = msssim(lena,image1,i,w);
    mssim2(i) = msssim(lena,image2,i,w);
    mssim3(i) = msssim(lena,image3,i,w);
    mssim4(i) = msssim(lena,image4,i,w);
    mssim5(i) = msssim(lena,image5,i,w);
    mssim6(i) = msssim(lena,image6,i,w);
    mssim7(i) = msssim(lena,image7,i,w);
end
real(mssim1)
real(mssim2)
real(mssim3)
real(mssim4)
real(mssim5)
real(mssim6)
real(mssim7)
avg_mssim1 = sum(mssim1)/5
avg_mssim2 = sum(mssim2)/5
avg_mssim3 = sum(mssim3)/5
avg_mssim4 = sum(mssim4)/5
avg_mssim5 = sum(mssim5)/5
avg_mssim6 = sum(mssim6)/5
avg_mssim7 = sum(mssim7)/5