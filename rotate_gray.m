angle = pi/1.5; %输入角度
I = imread('2.png');

%角度大于90度的，先旋转90度，再旋转剩下的角度
if angle>pi/2
    angle = angle - pi/2;   %角度减去90度
    %R = [cos(pi/2),sin(pi/2);-sin(pi/2),cos(pi/2)]; %R为从原图到结果的点坐标变换
    S = [cos(pi/2),-sin(pi/2);sin(pi/2),cos(pi/2)]; %S为从结果到原图的点坐标变换
    row1 = size(I,1);   %原图的行数
    column1 = size(I,2);    %原图的列数
    row = ceil(size(I,1)*cos(pi/2) + size(I,2)*sin(pi/2));  %旋转后的图的行数
    column = ceil(size(I,1)*sin(pi/2) + size(I,2)*cos(pi/2));   %旋转后的图的列数
    J = uint8(zeros(row,column));   %新建一个旋转后的图像，像素全为零
    for i = 1:row
        for j = 1:column  %遍历旋转后的图像的每一点
            B = ([i,j] - [column1*sin(pi/2),0])* S; %找到对应的原图的点
            B = ceil(B);    %把坐标向上取整
            if B(1)>=1 && B(1)<=row1 && B(2)>=1 && B(2)<=column1 %只对在原图上的点进行变换，不在的默认为0
                J(i,j) = I(B(1),B(2));
            end
        end
    end
    I = J;  %旋转后把结果变回I，以便后面的旋转
end

%R = [cos(angle),sin(angle);-sin(angle),cos(angle)];
S = [cos(angle),-sin(angle);sin(angle),cos(angle)];
row1 = size(I,1);
column1 = size(I,2);
row = ceil(size(I,1)*cos(angle) + size(I,2)*sin(angle));
column = ceil(size(I,1)*sin(angle) + size(I,2)*cos(angle));
J = uint8(zeros(row,column));


for i = 1:row
    for j = 1:column
        B = ([i,j] - [column1*sin(angle),0])* S;
        B = ceil(B);
        if B(1)>=1 && B(1)<=row1 && B(2)>=1 && B(2)<=column1
            J(i,j) = I(B(1),B(2));
        end
    end
end
figure,imshow(J);
