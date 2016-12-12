%%%%%%%%%%%%%%%%%% Program 5A %%%%%%%%%%%%%%%%
clc;
fig = imread('girl512.bmp'); %Read the image
fig = double(fig);

% Apply 2D-DFT to the input image
diff_fig = fft2(fig);

% Apply the Inverse Guassian filter
sigma_square = 34657;
[N1 N2]=size(fig);
g=zeros(N1/2,N2/2);
g_inv=zeros(N1/2,N2/2);
g_inv1=zeros(N1/2,N2/2);
g_inv2=zeros(N1/2,N2/2);
for k=1:N1/2
    for l=1:N2/2
        g(k,l)=exp((k^2+l^2)/(2*sigma_square));
        g_inv((N1/2)+1-k,(N2/2)+1-l)=g(k,l);
        g_inv1((N1/2)+1-k,l)=g(k,l);
        g_inv2(k,(N2/2)+1-l)=g(k,l);
    end
end
g_filter=zeros(N1,N2);
g_filter((1:N1/2),(1:N2/2))=g;
g_filter((N1/2)+1:N1,(N2/2)+1:N2)=g_inv;
g_filter((N1/2)+1:N1,1:(N2/2))=g_inv1;        
g_filter((1:(N1/2)),(N2/2)+1:N2)=g_inv2;
fil_diff_fig = (diff_fig).*g_filter;

% Apply 2D-IDFT to the filtered image
fil_fig = ifft2(fil_diff_fig);
subplot(1,2,1);
imshow(fig,[]);
title('Original image');
subplot(1,2,2);
imshow(uint8(fil_fig));
title('Filtered image');
figure;

% Display IGF(3D)
surf(g_filter,'EdgeColor', 'none'); 
colormap(hsv);
shading interp;
alpha(0.7);
grid on;
axis tight;