clear;
I = imread('pout.tif');    %输入图像
J = imread('cameraman.tif');  %目标图像
[h1,x] = imhist(J);
K = histeq(I,h1);
figure,imshow(K);
figure,imhist(K);
figure,imhist(I);

figure,imhist(J);