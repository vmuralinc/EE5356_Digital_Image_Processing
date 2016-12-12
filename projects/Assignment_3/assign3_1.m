clear all
clc

%reading .raw file to RGB
fileID = fopen('girl256color.raw');
A = fread(fileID);
status=fclose(fileID);

[row col] = size(A);

compSize = row/3;

R = zeros(compSize,1);
G = zeros(compSize,1);
B = zeros(compSize,1);

x=1;

for y = 1:1:(compSize)
    R(y) = A(x);
    G(y) = A(x+1);
    B(y) = A(x+2);
    x=x+3;
end

matSize = sqrt(compSize);

z=1;
for i = 1:1:matSize
    for j = 1:1:matSize
        R1(i,j) = R(z);
        G1(i,j) = G(z);
        B1(i,j) = B(z);
        z=z+1;
    end
end

subplot(2,2,1),imshow(uint8(R1)),title('R component');
subplot(2,2,2),imshow(uint8(G1)),title('G component');
subplot(2,2,3),imshow(uint8(B1)),title('B component');

% reconstruction of image from RGB

fullImage(:,:,1) = R1;
fullImage(:,:,2) = G1;
fullImage(:,:,3) = B1;
subplot(2,2,4),image(uint8(fullImage)); title('Reconstructed image');

% RGB to YUtVt

Y=(0.299*R1)+(0.587*G1)+(0.114*B1);
Ut=(-0.147*R1)+(-0.289*G1)+(0.436*B1);
Vt=(0.615*R1)+(-0.515*G1)+(-0.100*B1);

figure(2);
subplot(1,3,1),imshow(uint8(Y)),title('Y component')
subplot(1,3,2),imshow(uint8(Ut));title('Ut component')
subplot(1,3,3),imshow(uint8(Vt));title('Bt component')

% RGB to YdCbCr
Yd=(0.257*R1)+(0.504*G1)+(0.098*B1)+16;
Cb=(-0.148*R1)+(-0.291*G1)+(0.439*B1)+128;
Cr=(0.439*R1)+(-0.368*G1)+(-0.071*B1)+128;

figure(3);
subplot(1,3,1),imshow(uint8(Yd));title('Yd component')
subplot(1,3,2),imshow(uint8(Cr));title('Cb component')
subplot(1,3,3),imshow(uint8(Cb));title('Cr component')
