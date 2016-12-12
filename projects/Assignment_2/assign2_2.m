%read image
iImage1 = imread('goldhill256.bmp');

[row col] = size(iImage1);

% quantization level
L = 80;

% setting contrast equation values
a=1;
b=1/3;

contrastImage = zeros(row,col);
iImage2 = zeros(row,col);

% determining limits
t = 0:(a * (256^b))/L:(a * (256^b));
lenT = length(t);

% contrast quantization
for i = 1:row
    for j = 1:col
        sample = double(iImage1(i,j));
        % luminance to contrast
        sample = a*(sample^b);
        % quantization
        for k = 1:lenT-1
            if(sample >= t(k) && sample < t(k+1))
                contrastImage(i,j) = (t(k) + t(k+1)) / 2;
            end
        end
        % contrast to luminance
        iImage2(i,j) = (contrastImage(i,j)/a) ^(1/b);
    end
end

%MSE calculation
MSE = 0;

for i = 1:row
    for j = 1:col
        MSE = MSE + (double(iImage1(i,j)) - iImage2(i,j))^2;
    end
end

MSE = double(MSE / (row*col));

%PSNR calculation
PSNR = 10 * log10( 255^2 / MSE );

imshow(iImage1);

figure(2);
imshow(uint8(iImage2));