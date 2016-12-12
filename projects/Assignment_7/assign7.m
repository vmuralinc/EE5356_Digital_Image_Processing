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

invH1 = zeros(row,col);
invH2 = zeros(row,col);
invH3 = zeros(row,col);

for u = 1:row
    for v = 1:col
        if(H1(u,v) > 0.001)
            invH1(u,v) = 1/H1(u,v);
        end
        if(H2(u,v) > 0.001)
            invH2(u,v) = 1/H2(u,v);
        end
        if(H3(u,v) > 0.001)
            invH3(u,v) = 1/H3(u,v);
        end
    end
end

recImage1 = uint8(real(ifft2(ifftshift(G1.*invH1))));
recImage2 = uint8(real(ifft2(ifftshift(G2.*invH2))));
recImage3 = uint8(real(ifft2(ifftshift(G3.*invH3))));

figure,imshow(recImage1,[]),title('Inverse filter reconstructed image k=0.00025');
figure,imshow(recImage2,[]),title('Inverse filter reconstructed image k=0.0025');
figure,imshow(recImage3,[]),title('Inverse filter reconstructed image k=0.001');

% Ruu1 = xcorr2(double(image), double(image));
% Rnn1 = xcorr2(double(N), double(N));
% 
% Ruu = Ruu1(256:511,256:511);
% Rnn = Rnn1(256:511,256:511);
% 
% Suu = fftshift(fft2(Ruu));
% Snn = fftshift(fft2(Rnn));
% 
% W1 = (conj(H1).*Suu)./((abs(H1)).^2.*Suu+Snn);
% W2 = (conj(H2).*Suu)./((abs(H2)).^2.*Suu+Snn);
% W3 = (conj(H3).*Suu)./((abs(H3)).^2.*Suu+Snn);
% 
% recImage1 = abs(ifft2(ifftshift(W1.*G1)));
% recImage2 = abs(ifft2(ifftshift(W2.*G2)));
% recImage3 = abs(ifft2(ifftshift(W3.*G3)));
% 
% figure,imshow(recImage1,[]),title('Weiner filter reconstructed image k=0.00025');
% figure,imshow(recImage2,[]),title('Weiner filter reconstructed image k=0.0025');
% figure,imshow(recImage3,[]),title('Weiner filter reconstructed image k=0.001');
