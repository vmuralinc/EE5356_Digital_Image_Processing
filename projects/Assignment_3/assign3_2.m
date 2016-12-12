clear all
close all
clc

A = imread('flowers.bmp');

R = double(A(:,:,1));
G = double(A(:,:,2));
B = double(A(:,:,3));

Y=(0.257*R)+(0.504*G)+(0.098*B)+16;
Cb=(-0.148*R)+(-0.291*G)+(0.439*B)+128;
Cr=(0.439*R)+(-0.368*G)+(-0.071*B)+128;

% downsampling
  
Cr1 = downsample(Cr',2)';
Cb1 = downsample(Cb',2)';

% decimation of Y

LuminDeciFilter = [-29 0 88 138 88 0 -29]./256;

Y1 = imfilter(double(Y),LuminDeciFilter,'circular','conv');
Y3 = downsample(downsample(Y1,2)',2)';

% decimation of chrominance matrices

ChromDeciFilter = [1 3 3 1]./8;

Cr2 = imfilter(double(Cr1),ChromDeciFilter,'circular','conv');
Cr3 = downsample(downsample(Cr2,2)',2)';

Cb2 = imfilter(double(Cb1),ChromDeciFilter,'circular','conv');
Cb3 = downsample(downsample(Cb2,2)',2)';

% interpolation 

LumInterFilter = [-12 0 140 256 140 0 -12]./256;

Y4 = upsample(upsample(Y3,2)',2)';
Y5 = imfilter(double(Y4),LumInterFilter,'circular','conv');
Y6 = imfilter(double(Y5),LumInterFilter','circular','conv');

ChromInterFilter = [ 1 0 3 8 3 0 1]./8;

Cr4 = upsample(upsample(Cr3,2)',2)';
Cr5 = imfilter(Cr4,ChromInterFilter','circular','conv');
Cr6 = imfilter(Cr5,ChromInterFilter,'circular','conv');

Cb4 = upsample(upsample(Cb3,2)',2)';
Cb5 = imfilter(double(Cb4),ChromInterFilter,'circular','conv');
Cb6 = imfilter(double(Cb5),ChromInterFilter','circular','conv');

% upsampling

Cr7 = upsample(Cr6',2)';
[row col] = size(Cr7);
Cr7(:,col) = Cr7(:,col-1);
for count = 2:2:col-1
    Cr7(:,count) = (Cr7(:,count-1) + Cr7(:,count+1))/2;
end

Cb7 = upsample(Cb6',2)';
[row col] = size(Cb7);
Cb7(:,col) = Cb7(:,col-1);
for count = 2:2:col-1
    Cb7(:,count) = (Cb7(:,count-1) + Cb7(:,count+1))/2;
end

R1 = 1.164*(Y6-16) + 1.596*(Cr7-128);
G1 = 1.164*(Y6-16) - 0.813*(Cr7-128) - 0.392*(Cb7-128);
B1 = 1.164*(Y6-16) + 2.017*(Cb7-128);


image1 = zeros(362,500,3);
image1(:,:,1) = R1;
image1(:,:,2) = G1;
image1(:,:,3) = B1;

figure(1),
subplot(1,2,1), image(A), title('Original Image (500*362)'),
subplot(1,2,2), image(uint8(image1)), title('Reconstructed Image (500*362)'),

figure(2),
subplot(3,2,1), imshow(uint8(R)),title('Red Component');
subplot(3,2,2), imshow(uint8(G)),title('Green Component');
subplot(3,2,3), imshow(uint8(B)),title('Blue Component');
subplot(3,2,4), imshow(uint8(Y)),title('Luminance Y');
subplot(3,2,5), imshow(uint8(Cb)),title('Chroma Cb');
subplot(3,2,6), imshow(uint8(Cr)),title('Chroma Cr');

figure(3),
subplot(3,2,1),imshow(uint8(Y3)),title('Luminance Decimated Image(250*181)');
subplot(3,2,2),imshow(uint8(Cb3)),title('Cb Decimated Image(125*181)');
subplot(3,2,3),imshow(uint8(Cr3)),title('Cr Decimated Image(125*181)');
subplot(3,2,4),imshow(uint8(Y6)),title('Luminance Interpolated Image(500*362)');
subplot(3,2,5),imshow(uint8(Cb7)),title('Cb Interpolated Image(500*362)');
subplot(3,2,6),imshow(uint8(Cr7)),title('Cr Interpolated Image(500*362)');

figure(4),
subplot(3,1,1),imshow(uint8(R1)),xlabel('Reconstructed Red Component (500*362)');
subplot(3,1,2),imshow(uint8(G1)),xlabel('Reconstructed Green Component (500*362)');
subplot(3,1,3),imshow(uint8(B1)),xlabel('Reconstructed Blue Component (500*362)');