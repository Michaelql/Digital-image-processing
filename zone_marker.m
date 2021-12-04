%21、区域标记
clear;
I = imread('rice.png');
I = imbinarize(I);      %图像二值化
[row,column] = size(I); %获取图像的行列
Marker = uint8(zeros(row,column));  %新建输出图像，默认值为0
color = 0;  %代表连通区域的序号，也是连通区域的颜色
for i = 1:row
    for j = 1:column    %遍历所有的点
        if j == 1       %第一列单独讨论，防止j-1小于1报错
            if I(i,j) == 1  %第一列的元素为1时，代表一个连通区域的开始
                color = color + 1;  %连通区域数量加一
                %flag代表该行是否和上一行有相邻的情况，0代表没有，其他数字代表上一行的color值
                %start1和end1代表一行连续为1的列号的起始和结束
                %当flag不为0时，从start1开始到end1，这些像素改为上一行连通区域的颜色
                flag = 0;   
                start1 = j;
            end
            continue;
        end
        if (I(i,j) == 1 && I(i,j-1) == 0)   %这是判断一行内开始为白色的点
            color = color + 1;  %假定这个是一个新的连通区域
            Marker(i,j) = color;    %在标记图上把该点像素改为color值
            start1 = j;
            flag = 0;
            if(i ~= 1)    %因为第一行没有上一行，所以从第二行开始讨论是否与上一行联通
                %判断当前像素点的上面三个点（左上 正上 右上）是否为1，就是是否为连通区域
                if I(i-1,j) == 1 || I(i-1,max(1,j-1)) == 1 || I(i-1,min(column,j+1)) == 1
                    flag = Marker(i-1,j);   %如果是连通的话，将flag设为上一行的颜色
                end
            end
            if I(max(1,i-1),j) == 0 && I(min(row,i+1),j) == 0 && I(i,min(column,j+1)) == 0
               %判别这个点的上下左右邻近的点是否为黑色，如果是的话，意味着这个白点是个噪声，需要将其排除
               color = color - 1;   %连通区域减一，不影响连通区域的计数
               Marker(i,j) = 0;     %将此点设为黑色，忽略这个噪点
            end
        end
        if (I(i,j) == 1 && I(i,j-1) == 1)   %这是白色点的行内元素
            if(i ~= 1)    
                if I(i,j) == 1 && flag == 0     %判断是否与上一行相连通
                    flag = Marker(i-1,j);   
                end
            end
            Marker(i,j) = color;    %将该像素的值设为这片连通区域的color
        end
        if (I(i,j) == 0 && I(i,j-1) == 1)   %这是判断一行白色像素结束的点
            end1 = j;   %记录结束点的列坐标
            if flag ~= 0    %如果flag不为0，意味着该行与上一行相连通
                color = color - 1;  %连通区域数减一
                for k = start1:end1-1   %再将这行的值改成上一行的值
                    Marker(i,k) = flag;
                end
            end
        end
    end
end

%再遍历一次图像，将上一步有些区域没有合并的再次合并
for i = row-1:-1:1
    for j = 1:column    %遍历所有的点
        if (Marker(i,j) ~= 0 && Marker(i,max(1,j-1)) == 0)   %这是判断一行内开始为白色的点
            color = Marker(i,j);
            start1 = j;
            flag = 0;
        end
        if (Marker(i,j) ~= 0 && Marker(i,max(j-1,1)) ~= 0)   %这是白色点的行内元素 
            if Marker(i+1,j) ~= Marker(i,j)     %判断是否与上一行相连通
                flag = Marker(i+1,j);   
            end
            Marker(i,j) = color;    %将该像素的值设为这片连通区域的color
        end
        if (Marker(i,j) == 0 && Marker(i,max(1,j-1)) ~= 0)   %这是判断一行白色像素结束的点
            end1 = j;   %记录结束点的列坐标
            if flag ~= 0    %如果flag不为0，意味着该行与上一行相连通
                for k = start1:end1-1   %再将这行的值改成上一行的值
                    Marker(i,k) = flag;
                end
            end
        end
    end
end
figure,imshow(Marker);