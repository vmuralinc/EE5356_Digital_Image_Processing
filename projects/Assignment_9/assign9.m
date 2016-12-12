%lossless predictive coding

clear all;
clc;
close all;

U = double(imread('Lena512.bmp'));
[row col] = size(U);

Ubar = zeros(size(U));
for i = 1:1:row
    for j = 1:1:col
        if j > 1
            Ubar(i,j) = U(i,j-1);
        else
            Ubar(i,j) = U(i,j);
        end
    end
end

% prediction error
E = U - Ubar;

Udot = zeros(size(U));
%reconstruction
for i = 1:1:row
    for j = 1:1:col
        if j > 1 
            Udot(i,j) = E(i,j) + U(i,j-1);
        else
            Udot(i,j) = E(i,j) + U(i,j);
        end
    end
end

figure; imshow(U,[]),title('Lena Original Image');
figure; imshow(Udot,[]),title('Lena Reconstructed Image');
figure; imshow(E,[]),title('Prediction Error Image');

% figure,imhist(uint8(U));
% figure,imhist(uint8(E));

% figure;plot(Uhist),title('Histogram of Original Lena image');
% figure;plot(Ehist),title('Histogram of Prediction Error image');

% Uentropy = entropy(U);
% Eentropy = entropy(E);

[nU,xoutU] = hist(reshape(U,1,512*512),100);
figure(4);
bar(xoutU,nU);title('Image Histogram');
pU = nU/sum(nU);
entropyU=0;
 
for i=1:length(xoutU)
     if ( pU(i)>10e-8 )
            entropyU = entropyU - pU(i) * log2(pU(i));
     end
end
 
 
[nE,xoutE] = hist(reshape(E,1,512*512),100);
figure(5);
bar(xoutE,nE);title('Error Image Histogram');
pE = nE/sum(nE);
entropyE = 0;
for i=1:length(pE)
    if (pE(i)>10e-8)
        entropyE = entropyE - pE(i) * log2(pE(i));
    end
end

fprintf('Entropy of original image = %f',entropyU);
fprintf('Entropy of reconstructed image = %f',entropyE);