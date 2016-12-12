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

degImage1 = uint8(real(ifft2(ifftshift(G1))));
degImage2 = uint8(real(ifft2(ifftshift(G2))));
degImage3 = uint8(real(ifft2(ifftshift(G3))));

imshow(degImage1,[]),title('degraded image k=0.00025');
figure,imshow(degImage2,[]),title('degraded image k=0.0025');
figure,imshow(degImage3,[]),title('degraded image k=0.001');

Ruu1 = xcorr2(double(image), double(image));
Rnn1 = xcorr2(double(N), double(N));

Ruu = Ruu1(256:511,256:511);
Rnn = Rnn1(256:511,256:511);

Suu = fftshift(fft2(Ruu));
Snn = fftshift(fft2(Rnn));

alpha = 1/2; 
beta = 1;
Geo1 = (conj(H1)./abs(H1)).^alpha.*(conj(H1)./(abs(H1).^2 + beta.*((Snn./Suu).^(1-alpha))));
Geo2 = (conj(H2)./abs(H2)).^alpha.*(conj(H2)./(abs(H2).^2 + beta.*((Snn./Suu).^(1-alpha))));
Geo3 = (conj(H3)./abs(H3)).^alpha.*(conj(H3)./(abs(H3).^2 + beta.*((Snn./Suu).^(1-alpha))));

recImage1 = abs(ifft2(ifftshift(Geo1.*G1)));
recImage2 = abs(ifft2(ifftshift(Geo2.*G2)));
recImage3 = abs(ifft2(ifftshift(Geo3.*G3)));

figure,imshow(recImage1,[]),title('Geometric Mean filter recons image k=0.00025 & alpha = 1/2');
figure,imshow(recImage2,[]),title('Geometric Mean filter recons image k=0.0025 & alpha = 1/2');
figure,imshow(recImage3,[]),title('Geometric Mean filter recons image k=0.001 & alpha = 1/2');

alpha = 1/4; 
Geo1 = (conj(H1)./abs(H1)).^alpha.*(conj(H1)./(abs(H1).^2 + beta.*((Snn./Suu).^(1-alpha))));
Geo2 = (conj(H2)./abs(H2)).^alpha.*(conj(H2)./(abs(H2).^2 + beta.*((Snn./Suu).^(1-alpha))));
Geo3 = (conj(H3)./abs(H3)).^alpha.*(conj(H3)./(abs(H3).^2 + beta.*((Snn./Suu).^(1-alpha))));

recImage1 = abs(ifft2(ifftshift(Geo1.*G1)));
recImage2 = abs(ifft2(ifftshift(Geo2.*G2)));
recImage3 = abs(ifft2(ifftshift(Geo3.*G3)));

figure,imshow(recImage1,[]),title('Geometric Mean filter recons image k=0.00025 & alpha = 1/4');
figure,imshow(recImage2,[]),title('Geometric Mean filter recons image k=0.0025 & alpha = 1/4');
figure,imshow(recImage3,[]),title('Geometric Mean filter recons image k=0.001 & alpha = 1/4');

alpha = 3/4; 
Geo1 = (conj(H1)./abs(H1)).^alpha.*(conj(H1)./(abs(H1).^2 + beta.*((Snn./Suu).^(1-alpha))));
Geo2 = (conj(H2)./abs(H2)).^alpha.*(conj(H2)./(abs(H2).^2 + beta.*((Snn./Suu).^(1-alpha))));
Geo3 = (conj(H3)./abs(H3)).^alpha.*(conj(H3)./(abs(H3).^2 + beta.*((Snn./Suu).^(1-alpha))));

recImage1 = abs(ifft2(ifftshift(Geo1.*G1)));
recImage2 = abs(ifft2(ifftshift(Geo2.*G2)));
recImage3 = abs(ifft2(ifftshift(Geo3.*G3)));

figure,imshow(recImage1,[]),title('Geometric Mean filter recons image k=0.00025 & alpha = 3/4');
figure,imshow(recImage2,[]),title('Geometric Mean filter recons image k=0.0025 & alpha = 3/4');
figure,imshow(recImage3,[]),title('Geometric Mean filter recons image k=0.001 & alpha = 3/4');