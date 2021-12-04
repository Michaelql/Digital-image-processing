%这是彩色图像的旋转，和灰度图像类似，只是将rgb三个分量分别做一次旋转，最后再拼接起来就可以了
angle = pi/4; %输入角度

A = imread('1.jpg');

%R = [cos(angle),sin(angle);-sin(angle),cos(angle)];
S = [cos(angle),-sin(angle);sin(angle),cos(angle)];
row1 = size(A,1);   %原图的行数
column1 = size(A,2);
row = ceil(size(A,1)*cos(angle) + size(A,2)*sin(angle));
column = ceil(size(A,1)*sin(angle) + size(A,2)*cos(angle));
Out = uint8(zeros(row,column,3));

for k = 1:3
    J = uint8(zeros(row,column));
    I = A(:,:,k);
    for i = 1:row
        for j = 1:column
            B = ([i,j] - [column1*sin(angle),0])* S;
            B = ceil(B);
            if B(1)>=1 && B(1)<=row1 && B(2)>=1 && B(2)<=column1
                J(i,j) = I(B(1),B(2));
            end
        end
    end
    Out(:,:,k) = J;
end 
figure,imshow(Out);
