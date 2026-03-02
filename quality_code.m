title('regularized filter restoration')


[peaksnr,z] = psnr(deconv_img, img_org);
  
fprintf('\n The Peak-SNR value is %0.4f', peaksnr,z);

ssim

[ssimval,ssimmap] = ssim(deconv_img, img_org);
figure(5)
imshow(ssimmap,[])
title(['Local SSIM Map with Global SSIM Value: ',num2str(ssimval)])
 
measure the sharpness of original image


sharpness=estimate_sharpness(img_org);
disp(['Sharpness of original image: ' num2str(sharpness)]);
 
sharpness=estimate_sharpness(y0);
disp(['Sharpness of blurred image: ' num2str(sharpness)]);


sharpness=estimate_sharpness(y);
disp(['Sharpness of blurred_noised image: ' num2str(sharpness)]);

sharpness=estimate_sharpness(fL2);
%disp(['Sharpness of restored image: ' num2str(sharpness)]);