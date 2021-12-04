%17 频域低通滤波
clear;
I = imread('cameraman.tif');  %输入图像
d0 = 60;  %阈值
I = imnoise(I,'gaussian');  %加高斯噪声
F = fftshift(fft2(double(I)));  %傅里叶变换得到频谱
[row, column] = size(F);
row_middle = fix(row/2);  %求出图像的中点
column_middle = fix(column/2);  
Out = zeros(row,column);    %初始化输出结果图片

for i = 1:row
    for j = 1:column
        d = max(abs(i-row_middle),abs(j-column_middle));   %理想低通滤波，求距离
        if d <= d0  %判断距离是否大于阈值
            Out(i,j) = F(i,j);  %小于阈值的话，保留原来的频谱
        else
            Out(i,j) = 0;   %大于阈值的话，将其频谱置为0
        end
    end
end

subplot(2,2,1);imshow(I);title('加了高斯噪声的图像');
subplot(2,2,2);imshow(real(F));title('原图的频谱图');
subplot(2,2,4);imshow(real(Out));title('低通滤波后的频谱');
Out=ifftshift(Out);    %反傅里叶变换
Out=uint8(real(ifft2(Out)));  %取实数部分
subplot(2,2,3);imshow(Out);title('低通滤波结果');

