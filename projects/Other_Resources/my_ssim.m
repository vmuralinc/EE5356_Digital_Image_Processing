function [SSIM_metric SSIM_map] = my_ssim(img1,img2,alph,beta,gamma,C1,C2,C3)

window = fspecial('gaussian', 11, 1.5);	%
window = window/sum(sum(window));
image1 = double(img1);
image2 = double(img2);

mu1   = filter2(window, image1, 'valid');
mu2   = filter2(window, image2, 'valid');
mu1_sq = mu1.*mu1;
mu2_sq = mu2.*mu2;
mu1_mu2 = mu1.*mu2;
sigma1_sq = filter2(window, image1.*image1, 'valid') - mu1_sq;
sigma2_sq = filter2(window, image2.*image2, 'valid') - mu2_sq;
sigma12 = filter2(window, image1.*image2, 'valid') - mu1_mu2;

numerator1 = 2.*mu1_mu2 + C1;
numerator2 = 2.*(sqrt(sigma1_sq).*sqrt(sigma2_sq)) + C2;
numerator3 = sigma12 + C3;
denominator1 = mu1_sq + mu2_sq + C1;
denominator2 = sigma1_sq + sigma2_sq + C2;
denominator3 = (sqrt(sigma1_sq) .* sqrt(sigma2_sq)) + C3;
SSIM_map = ones(size(mu1));
index = (denominator1 > 0);
SSIM_map(index) = SSIM_map(index) .* (numerator1(index)./denominator1(index)).^alph;
index = (denominator2 > 0);
SSIM_map(index) = SSIM_map(index) .* (numerator2(index)./denominator2(index)).^beta;
index = (denominator3 > 0);
SSIM_map(index) = SSIM_map(index) .* (numerator3(index)./denominator3(index)).^gamma;

SSIM_metric = mean2(SSIM_map);

return
