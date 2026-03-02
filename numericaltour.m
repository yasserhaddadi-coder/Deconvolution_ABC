getd = @(p)path(p,path)
getd('toolbox_signal/');
getd('toolbox_general/');

n = 256;
name = 'abscess';
f0 = load_image(name);
f0 = rescale(crop(f0,n));

s = 3;

x = [0:n/2-1, -n/2:-1];
[Y,X] = meshgrid(x,x);
h = exp( (-X.^2-Y.^2)/(2*s^2) );
h = h/sum(h(:));

hF = real(fft2(h));

clf;
figure(1)
imshow(h)
figure(2)
imshow(hF)
%imageplot(fftshift(h), 'Filter', 1,2,1);
%imageplot(fftshift(hF), 'Fourier transform', 1,2,2);

if using_matlab()
    Phi = @(x,h)real(ifft2(fft2(x).*fft2(h)));
end

y0 = Phi(f0,h);

clf;
figure(3)
imshow(f0)
figure(4)
imshow(y0)
%imageplot(f0, 'Image f0', 1,2,1);
%imageplot(y0, 'Observation without noise', 1,2,2);

sigma = .04;

y = y0 + randn(n)*sigma;

clf;
figure(5)
imshow(y0)
figure(6)
imshow(y)
%imageplot(y0, 'Observation without noise', 1,2,1);
%imageplot(clamp(y), 'Observation with noise', 1,2,2);

yF = fft2(y);

lambda = 0.4913;

fL2 = real( ifft2( yF .* hF ./ ( abs(hF).^2 + lambda) ) );

clf;
figure(7)
imshow(y)
figure(8)
imshow(fL2)
%imageplot(y, strcat(['Observation, SNR=' num2str(snr(f0,y),3) 'dB']), 1,2,1);
%imageplot(clamp(fL2), strcat(['L2 deconvolution, SNR=' num2str(snr(f0,fL2),3) 'dB']), 1,2,2);

clf;
figure(9)
imshow(y)
figure(10)
imshow(fL2)

%imageplot(y, strcat(['Observation, SNR=' num2str(snr(f0,y),3) 'dB']), 1,2,1);
%imageplot(clamp(fL2), strcat(['L2 deconvolution, SNR=' num2str(snr(f0,fL2),3) 'dB']), 1,2,2);

[peaksnr] = psnr(fL2, f0);
  
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);


[ssimval, ssimmap] = ssim(fL2,f0);
figure(11)
imshow(ssimmap,[])
title("Local SSIM Map with Global SSIM Value: "+num2str(ssimval))
 
% measure the sharpness of original image

sharpness=estimate_sharpness(f0);
disp(['Sharpness of original image: ' num2str(sharpness)]);
 
sharpness=estimate_sharpness(y0);
disp(['Sharpness of blurred image: ' num2str(sharpness)]);


sharpness=estimate_sharpness(y);
disp(['Sharpness of blurred_noised image: ' num2str(sharpness)]);

sharpness=estimate_sharpness(fL2);
disp(['Sharpness of restored image: ' num2str(sharpness)]);
