%边界跟踪并实现顺时针输出
clear;
I = imread('3.png');    %输入图像
I = imbinarize(I);      %图像二值化
[row,column] = size(I); %获取图像的行列
Out = imbinarize(zeros(row,column));
% 采用八领域作为边界条件
offset_8 = [-1,0;-1,1;0,1;1,1;1,0;1,-1;0,-1;-1,-1];
match_list = [6,7,8,1,2,3,4,5];
[a,b] = find(I==1);
start_point = [a(1),b(1)];  %找到起始点

current_point = start_point;    %另当前点为起始点
dir = 1;    %起始方向为右上
result = (start_point);
mark = 1;
while (max(current_point ~= start_point))||(mark)
    temp_point = current_point + offset_8(dir,:);
%     通过两个判断条件，来判断当前点是不是边界点
    if (I(temp_point(1),temp_point(2))==1) && (sum(sum(I(temp_point(1)-1:temp_point(1)+1,temp_point(2)-1:temp_point(2)+1)))~=9)
        dir = match_list(dir);
        current_point = temp_point;
        result = [result;current_point];
        mark = 0;
    else
        dir = dir+1;
        if dir == 9
            dir = 1;
        end
    end
end
[new_m,new_n] = size(result);
for i = 1:new_m
    Out(result(i,1),result(i,2)) = 1;
end
figure,imshow(Out);
%figure,imshow(mark_img);
for i=1:length(result)
    disp(result(i,:))
end