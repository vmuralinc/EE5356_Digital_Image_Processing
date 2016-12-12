clear all
close all
clc;

imageOrg = imread('goldhill256.bmp');
[row col] = size(imageOrg);
figure(1), imshow(imageOrg),title('Original Image');
MSE = zeros(1,10);

% gaussian noise
mean = 0;
v = 0.01;
gaussianImage = imnoise(imageOrg,'gaussian',mean,v);
modGaussImage = zeros(row+2,col+2);
modGaussImage(2:1:row+1,2:1:col+1) = gaussianImage(:,:);
modGaussImage(:,1) = modGaussImage(:,2);
modGaussImage(:,col+2) = modGaussImage(:,col+1);
modGaussImage(1,:) = modGaussImage(2,:);
modGaussImage(row+2,:) = modGaussImage(row+1,:);

%poisson noise
poissonImage = imnoise(imageOrg,'poisson');
modPoissImage = zeros(row+2,col+2);
modPoissImage(2:1:row+1,2:1:col+1) = poissonImage(:,:);
modPoissImage(:,1) = modPoissImage(:,2);
modPoissImage(:,col+2) = modPoissImage(:,col+1);
modPoissImage(1,:) = modPoissImage(2,:);
modPoissImage(row+2,:) = modPoissImage(row+1,:);

% salt & pepper noise
D = 0.05;
spImage = imnoise(imageOrg,'salt & pepper',D);
modSpImage = zeros(row+2,col+2);
modSpImage(2:1:row+1,2:1:col+1) = spImage(:,:);
modSpImage(:,1) = modSpImage(:,2);
modSpImage(:,col+2) = modSpImage(:,col+1);
modSpImage(1,:) = modSpImage(2,:);
modSpImage(row+2,:) = modSpImage(row+1,:);

% speckle noise
V = 0.05;
speckleImage = imnoise(imageOrg,'speckle',V);
modSpeckleImage = zeros(row+2,col+2);
modSpeckleImage(2:1:row+1,2:1:col+1) = speckleImage(:,:);
modSpeckleImage(:,1) = modSpeckleImage(:,2);
modSpeckleImage(:,col+2) = modSpeckleImage(:,col+1);
modSpeckleImage(1,:) = modSpeckleImage(2,:);
modSpeckleImage(row+2,:) = modSpeckleImage(row+1,:);

figure(2),
subplot(2,2,1),imshow(gaussianImage), title('Gaussian noisy image');
subplot(2,2,2), imshow(poissonImage), title('Poisson noisy image');
subplot(2,2,3), imshow(spImage), title('Salt & pepper noisy image');
subplot(2,2,4), imshow(speckleImage),title('Speckle noisy image');

m = 3; % window row size 
n = 3; % window column size

% arithmetic filter
fun = @(x) arithmetic(x(:));
meanImage = nlfilter(double(modGaussImage),[m n],fun);
figure(3),
subplot(2,2,1),imshow(uint8(meanImage(2:1:row+1,2:1:col+1))),title('Gaussian');
meanImage = nlfilter(double(modPoissImage),[m n],fun);
subplot(2,2,2),imshow(uint8(meanImage(2:1:row+1,2:1:col+1))),title('Poisson');
meanImage = nlfilter(double(modSpImage),[m n],fun);
error = imageOrg - uint8(meanImage(2:1:row+1,2:1:col+1));
MSE(1) = sum(sum(error .* error)) / (row * col);
subplot(2,2,3),imshow(uint8(meanImage(2:1:row+1,2:1:col+1))),title('Salt & pepper');
meanImage = nlfilter(double(modSpeckleImage),[m n],fun);
subplot(2,2,4),imshow(uint8(meanImage(2:1:row+1,2:1:col+1))),title('Speckle');

% geometric filter
fun1 = @(x) geometric(x(:));
geoImage = nlfilter(double(modGaussImage),[m n],fun1);
figure(4),
subplot(2,2,1),imshow(uint8(geoImage(2:1:row+1,2:1:col+1))),title('Gaussian');
geoImage = nlfilter(double(modPoissImage),[m n],fun1);
subplot(2,2,2),imshow(uint8(geoImage(2:1:row+1,2:1:col+1))),title('Poisson');
geoImage = nlfilter(double(modSpImage),[m n],fun1);
error = imageOrg - uint8(geoImage(2:1:row+1,2:1:col+1));
MSE(2) = sum(sum(error .* error)) / (row * col);
subplot(2,2,3),imshow(uint8(geoImage(2:1:row+1,2:1:col+1))),title('Salt & pepper');
geoImage = nlfilter(double(modSpeckleImage),[m n],fun1);
subplot(2,2,4),imshow(uint8(geoImage(2:1:row+1,2:1:col+1))),title('Speckle');

%harmonic filter
fun2 = @(x) harmonic(x(:));
harmoImage = nlfilter(double(modGaussImage),[m n],fun2);
figure(5),
subplot(2,2,1),imshow(uint8(harmoImage(2:1:row+1,2:1:col+1))),title('Gaussian');
harmoImage = nlfilter(double(modPoissImage),[m n],fun2);
subplot(2,2,2),imshow(uint8(harmoImage(2:1:row+1,2:1:col+1))),title('Poisson');
harmoImage = nlfilter(double(modSpImage),[m n],fun2);
error = imageOrg - uint8(harmoImage(2:1:row+1,2:1:col+1));
MSE(3) = sum(sum(error .* error)) / (row * col);
subplot(2,2,3),imshow(uint8(harmoImage(2:1:row+1,2:1:col+1))),title('Salt & pepper');
harmoImage = nlfilter(double(modSpeckleImage),[m n],fun2);
subplot(2,2,4),imshow(uint8(harmoImage(2:1:row+1,2:1:col+1))),title('Speckle');

%contraharmonic filter
fun3 = @(x) contraharmonic(x(:));
contraImage = nlfilter(double(modGaussImage),[m n],fun3);
figure(6),
subplot(2,2,1),imshow(uint8(contraImage(2:1:row+1,2:1:col+1))),title('Gaussian');
contraImage = nlfilter(double(modPoissImage),[m n],fun3);
subplot(2,2,2),imshow(uint8(contraImage(2:1:row+1,2:1:col+1))),title('Poisson');
contraImage = nlfilter(double(modSpImage),[m n],fun3);
error = imageOrg - uint8(contraImage(2:1:row+1,2:1:col+1));
MSE(4) = sum(sum(error .* error)) / (row * col);
subplot(2,2,3),imshow(uint8(contraImage(2:1:row+1,2:1:col+1))),title('Salt & pepper');
contraImage = nlfilter(double(modSpeckleImage),[m n],fun3);
subplot(2,2,4),imshow(uint8(contraImage(2:1:row+1,2:1:col+1))),title('Speckle');

% Median filter
medImage = medfilt2(gaussianImage,[m n],'symmetric');
figure(7),
subplot(2,2,1),imshow(uint8(medImage)),title('Gaussian');
medImage = medfilt2(poissonImage,[m n],'symmetric');
subplot(2,2,2),imshow(uint8(medImage)),title('Poisson');
medImage = medfilt2(spImage,[m n],'symmetric');
error = imageOrg - uint8(medImage);
MSE(5) = sum(sum(error .* error)) / (row * col);
subplot(2,2,3),imshow(uint8(medImage)),title('Salt & pepper');
medImage = medfilt2(speckleImage,[m n],'symmetric');
subplot(2,2,4),imshow(uint8(medImage)),title('Speckle');

% Max filter
maxImage = ordfilt2(gaussianImage,m*n,ones(m,n),'symmetric');
figure(8),
subplot(2,2,1),imshow(uint8(maxImage)),title('Gaussian');
maxImage = ordfilt2(poissonImage,m*n,ones(m,n),'symmetric');
subplot(2,2,2),imshow(uint8(maxImage)),title('Poisson');
maxImage = ordfilt2(spImage,m*n,ones(m,n),'symmetric');
error = imageOrg - uint8(maxImage);
MSE(6) = sum(sum(error .* error)) / (row * col);
subplot(2,2,3),imshow(uint8(maxImage)),title('Salt & pepper');
maxImage = ordfilt2(speckleImage,m*n,ones(m,n),'symmetric');
subplot(2,2,4),imshow(uint8(maxImage)),title('Speckle');

% Min filter
minImage = ordfilt2(gaussianImage,1,ones(m,n),'symmetric');
figure(9),
subplot(2,2,1),imshow(uint8(minImage)),title('Gaussian');
minImage = ordfilt2(poissonImage,1,ones(m,n),'symmetric');
subplot(2,2,2),imshow(uint8(minImage)),title('Poisson');
minImage = ordfilt2(spImage,1,ones(m,n),'symmetric');
error = imageOrg - uint8(minImage);
MSE(7) = sum(sum(error .* error)) / (row * col);
subplot(2,2,3),imshow(uint8(minImage)),title('Salt & pepper');
minImage = ordfilt2(speckleImage,1,ones(m,n),'symmetric');
subplot(2,2,4),imshow(uint8(minImage)),title('Speckle');

% mid-point filter
f1 = ordfilt2(gaussianImage, 1, ones(m,n), 'symmetric'); 
f2 = ordfilt2(gaussianImage, m*n, ones(m,n), 'symmetric'); 
mpImage = imlincomb(0.5, f1, 0.5, f2); 
figure(10),
subplot(2,2,1),imshow(uint8(mpImage)),title('Gaussian');
f1 = ordfilt2(poissonImage, 1, ones(m,n), 'symmetric'); 
f2 = ordfilt2(poissonImage, m*n, ones(m,n), 'symmetric'); 
mpImage = imlincomb(0.5, f1, 0.5, f2); 
subplot(2,2,2),imshow(uint8(mpImage)),title('Poisson');
f1 = ordfilt2(spImage, 1, ones(m,n), 'symmetric'); 
f2 = ordfilt2(spImage, m*n, ones(m,n), 'symmetric'); 
mpImage = imlincomb(0.5, f1, 0.5, f2); 
error = imageOrg - uint8(mpImage);
MSE(8) = sum(sum(error .* error)) / (row * col);
subplot(2,2,3),imshow(uint8(mpImage)),title('Salt & pepper');
f1 = ordfilt2(speckleImage, 1, ones(m,n), 'symmetric'); 
f2 = ordfilt2(speckleImage,m*n, ones(m,n), 'symmetric'); 
mpImage = imlincomb(0.5, f1, 0.5, f2); 
subplot(2,2,4),imshow(uint8(mpImage)),title('Speckle');

% alpha trimmed mean filter
d = 6;
atmImage = imfilter(double(gaussianImage), ones(m, n), 'symmetric'); 
for k = 1:d/2 
   atmImage = imsubtract(atmImage, ordfilt2(double(gaussianImage), k, ones(m, n), 'symmetric')); 
end 
for k = (m*n - (d/2) + 1):m*n 
   atmImage = imsubtract(atmImage, ordfilt2(double(gaussianImage), k, ones(m, n), 'symmetric')); 
end 
atmImage = atmImage / (m*n - d); 
figure(11),
subplot(2,2,1),imshow(uint8(atmImage)),title('Gaussian');
atmImage = imfilter(double(poissonImage), ones(m, n), 'symmetric'); 
for k = 1:d/2 
   atmImage = imsubtract(atmImage, ordfilt2(double(poissonImage), k, ones(m, n), 'symmetric')); 
end 
for k = (m*n - (d/2) + 1):m*n 
   atmImage = imsubtract(atmImage, ordfilt2(double(poissonImage), k, ones(m, n), 'symmetric')); 
end 
atmImage = atmImage / (m*n - d); 
subplot(2,2,2),imshow(uint8(atmImage)),title('Poisson');
atmImage = imfilter(double(spImage), ones(m, n), 'symmetric'); 
for k = 1:d/2 
   atmImage = imsubtract(atmImage, ordfilt2(double(spImage), k, ones(m, n), 'symmetric')); 
end 
for k = (m*n - (d/2) + 1):m*n 
   atmImage = imsubtract(atmImage, ordfilt2(double(spImage), k, ones(m, n), 'symmetric')); 
end 
atmImage = atmImage / (m*n - d); 
error = imageOrg - uint8(atmImage);
MSE(9) = sum(sum(error .* error)) / (row * col);
subplot(2,2,3),imshow(uint8(atmImage)),title('Salt & pepper');
atmImage = imfilter(double(speckleImage), ones(m, n), 'symmetric'); 
for k = 1:d/2 
   atmImage = imsubtract(atmImage, ordfilt2(double(spImage), k, ones(m, n), 'symmetric')); 
end 
for k = (m*n - (d/2) + 1):m*n 
   atmImage = imsubtract(atmImage, ordfilt2(double(spImage), k, ones(m, n), 'symmetric')); 
end 
atmImage = atmImage / (m*n - d); 
subplot(2,2,4),imshow(uint8(atmImage)),title('Speckle');