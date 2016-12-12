clear all
clc

% RGB to YIQ
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

Y = (0.299 * R1) + (0.587 * G1) + (0.114 *  B1);
I = (0.596 * R1) - (0.274 * G1) - (0.322 *  B1);
Q = (0.211 * R1) - (0.523 * G1) + (0.312 *  B1);

subplot(2,3,1),imshow(uint8(Y)),title('Y component');
subplot(2,3,2),imshow(uint8(I)),title('I component');
subplot(2,3,3),imshow(uint8(Q)),title('Q component');

R2 = Y + (0.956 * I) + (0.621 * Q);
G2 = Y - (0.272 * I) - (0.647 * Q);
B2 = Y - (1.106 * I) + (1.703 * Q);

subplot(2,3,4),imshow(uint8(R2)),title('R component');
subplot(2,3,5),imshow(uint8(G2)),title('G component');
subplot(2,3,6),imshow(uint8(B2)),title('B component');

% color space conversion

A = imread('flowers.bmp');

R3 = double(A(:,:,1));
G3 = double(A(:,:,2));
B3 = double(A(:,:,3));

% image(A);

C0 = bitshift((R3 - B3),-1);
t = B3 + C0; 
Cg = bitshift((G3 - t),-1);
Ys = bitshift((G3 + t),-1);
figure(2)
subplot(2,3,1),imshow(uint8(Ys)),title('Ys component');
subplot(2,3,2),imshow(uint8(C0)),title('C0 component');
subplot(2,3,3),imshow(uint8(Cg)),title('Cg component');

% inverse color space conversion

G4 = Ys + Cg;
t = Ys - Cg;
B4 = t - C0;
R4 = t + C0;
        
subplot(2,3,4),imshow(uint8(R4)),title('R component');
subplot(2,3,5),imshow(uint8(G4)),title('G component');
subplot(2,3,6),imshow(uint8(B4)),title('B component');

image1(:,:,1) = R4;
image1(:,:,2) = G4;
image1(:,:,3) = B4;
figure(3),image(uint8(image1));