close all;
clear all;
clc;

image = imread('goldhill256.bmp');

[row col] = size(image);

fftImage = fftshift(fft2(image));

k1 = 0.00025;
k2 = 0.0025;
k3 = 0.001;

H1 = zeros(row,col);
H2 = zeros(row,col);
H3 = zeros(row,col);

for u = 1:row
    for v = 1:col
        H1(u,v) = exp(-k1 .*((u-row/2)^2 + (v-col/2)^2));
        H2(u,v) = exp(-k2 .*((u-row/2)^2 + (v-col/2)^2));
        H3(u,v) = exp(-k3 .*((u-row/2)^2 + (v-col/2)^2));
    end
end

N = randn(row,col);

G1 = (fftImage .* H1) + N;
G2 = (fftImage .* H2) + N;
G3 = (fftImage .* H3) + N;

degImage1 = uint8(abs(ifft2(ifftshift(G1))));
degImage2 = uint8(abs(ifft2(ifftshift(G2))));
degImage3 = uint8(abs(ifft2(ifftshift(G3))));

imshow(degImage1,[]),title('degraded image k=0.00025');
figure,imshow(degImage2,[]),title('degraded image k=0.0025');
figure,imshow(degImage3,[]),title('degraded image k=0.001');

H1_conj = conj(H1);
H2_conj = conj(H2);
H3_conj = conj(H3);

P = zeros(row,col);
P(row/2,col/2) = 4;
P(row/2-1,col/2) = -1;
P(row/2+1,col/2) = -1;
P(row/2,col/2-1) = -1;
P(row/2,col/2+1) = -1;

gamma = 0.0001;

CLS1=H1_conj./((abs(H1).^2)+(gamma.*(abs(fftshift(fft2(P))).^2)));
CLS2=H2_conj./((abs(H2).^2)+(gamma.*(abs(fftshift(fft2(P))).^2)));
CLS3=H3_conj./((abs(H3).^2)+(gamma.*(abs(fftshift(fft2(P))).^2)));

recImage1 = uint8(abs(ifft2(ifftshift(G1.*CLS1))));
recImage2 = uint8(abs(ifft2(ifftshift(G2.*CLS2))));
recImage3 = uint8(abs(ifft2(ifftshift(G3.*CLS3))));

figure,imshow(recImage1,[]),title('Constrained Least Square Error Restoration, K=0.00025');
figure,imshow(recImage2,[]),title('Constrained Least Square Error Restoration, K=0.0025')
figure,imshow(recImage3,[]),title('Constrained Least Square Error Restoration, K=0.001');
