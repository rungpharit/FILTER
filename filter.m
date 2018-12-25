I=imread('Test.PNG');
Im=rgb2gray(I);
boat=imread('boat.JPG');
gray=rgb2gray(boat);

%%SMOOTHING FILTER
noisy_smoothing = imnoise(gray,'Gaussian',0.04,0.003);
sigma = 1;
kernel = zeros(5,5);
w = 0;

for i=1:5
   for j=1:5
      sq_dist = (i-3)^2 + (j-3)^2;
      kernel(i,j) = exp(-1*(sq_dist)/(2*sigma*sigma));
      w = w + kernel(i,j);
   end
end
kernel = kernel/w;

[m_smoothing,n_smoothing] = size(boat);
smoothing = zeros(m_smoothing,n_smoothing);
mm= padarray(boat,[2 2]);

for i=1:m_smoothing
   for j=1:n_smoothing
       hi = mm(i:i+4 , j:j+4);
       hi = double(hi);
       conv = hi.*kernel;
       smoothing(i,j)=sum(conv(:));
   end
end

%smoothing_=uint8(smoothing);
%figure
%imshow(boat),title('Original Image');
%figure
%imshow(noisy_smoothing),title('noise Image');
%figure
%imshow(smoothing_),title('Smoothing Image');
%figure
  %%`MEDIAN FILTER
noisy_salt = imnoise(Im,'salt & pepper',0.1);
[m_median,n_median]=size(noisy_salt);

output = zeros(m_median,n_median);
output = uint8(output);

for i = 1:m_median
   for j = 1:n_median
       xmin = max(1,i-1);
       xmax = min(m_median,i+1);
       ymin = max(1,j-1);
       ymax = min(n_median,j+1);
       
       test = noisy_salt(xmin:xmax,ymin:ymax);
       output(i,j) = median(test(:));
   end
end


imshow(I),title('Original Image');
figure
imshow(noisy_salt),title('Noisy Image');
figure
imshow(output),title('Median Image');
figure