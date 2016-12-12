% 2D DPCM
clear all;
clc;
close all;

U = imread('goldhill256.bmp');
[row col] = size(U);
Udouble = double(U);
a1 = 0.95;
a2 = 0.95;
a3 = -a1*a2;
a4 = 0;
  
quantlevels = input('Enter number of quantization levels : ');
q = 256/quantlevels;
  
Ebar = zeros(size(U));
Uqbar = Ebar;
E = Ebar;
Uq = Ebar; 

t = 0:q:q*quantlevels;

r = zeros(1,quantlevels);
for k = 1 : quantlevels
    r(k) = t(k) + (q/2);  
end

for i = 1:1:row
    for j = 1:1:col
        
        E(i,j) = Udouble(i,j) - Uqbar(i,j);

        % quantization process
        for k = 1:quantlevels
            if (E(i,j) >= t(k) && E(i,j) < t(k+1))
                Ebar(i,j) = r(k);
            end
        end

        Uq(i,j) = Ebar(i,j) + Uqbar(i,j);

        if i > 1
            Uqbar(i,j) = Uqbar(i,j) + a1*Uq(i-1,j);
            if j > 1
                Uqbar(i,j) = Uqbar(i,j) + a3*Uq(i-1,j-1);
            end
            if j < col
                Uqbar(i,j) = Uqbar(i,j) + a4*Uq(i-1,j+1);
            end
        end
        if j > 1
            Uqbar(i,j) = Uqbar(i,j) + a2*Uq(i,j-1);
        end
    end
end
               
sq_err = 0;
for i = 1:row
    for j = 1:col
        sq_err = sq_err + (Udouble(i,j)- Uq(i,j))^2;
    end
end
mse = sq_err/(row*col);         % MSE calculation
variance =  var(var(E));
psnr = 10 * log10(variance/mse);     % PSNR calculation
    
% Reconstruction filter

Uq = Ebar + Uqbar;             

figure; imshow(U,[]); title('Original Image');
figure; imshow(Uq,[]); title('Reconstructed Image');      
disp(psnr);