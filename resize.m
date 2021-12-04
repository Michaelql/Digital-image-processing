% 1.图像放大缩小
P = 600;    %伸缩后的行数
Q = 800;    %伸缩后的列数
J = imread('2.png');
x = P/size(J,1);    %行变换系数
y = Q/size(J,2);    %列变换系数
%K = J(: , end:-1:1);   %左右镜像

K = zeros(P,Q);
for j = 1:Q
    for i = 1:P
        K(i, j) = J(round(i/x),round(j/y));
    end
end
K = uint8(K);
subplot(1,2,1);
imshow(J);title('原图')
subplot(1,2,2);
imshow(K);title('缩放后的图')

