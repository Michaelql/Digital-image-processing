clear;
I = imread('pout.tif');    %输入图像
J = imread('cameraman.tif');  %目标图像
goal_freq = zeros(1,256);   %目标图像的灰度频率
goal_count = zeros(1,256);   %目标图像的灰度个数
in_freq = zeros(1,256);  %输入图像的灰度频率
in_count = zeros(1,256);  %输入图像的灰度个数
out_count = zeros(1,256);   %输出图像的灰度个数
[row,column] = size(I); %输入图像的大小
Out = zeros(row,column);

for i = 1:256
    goal_freq(i)=length(find(J==i))/(size(J,1)*size(J,2)); %计算目标图像的各个灰度的出现频率
    out_count(i)=goal_freq(i)*row*column;  %输出图像的各个灰度出现的次数
end
goal_sum_freq = goal_freq;
for i = 2:256
    goal_sum_freq(i)=goal_sum_freq(i)+goal_sum_freq(i-1);    %计算目标图像的各个灰度的累计频率
end

for i = 1:256
    in_freq(i)=length(find(I==i))/(size(I,1)*size(I,2)); %计算输入图像的各个灰度的出现频率
    in_count(i)=in_freq(i)*row*column;
end


figure,subplot(3,2,3),bar(0:255,in_freq);

g1s = in_freq;
for i = 2:256
    g1s(i)=g1s(i)+g1s(i-1);
end
i1 = 0;
j1 = 0;
for i = 1:256       %遍历目标图像
    for j = 1:255   %遍历输入图像
        if in_count(j) < goal_count(i)
            in_count(j+1) = in_count(j+1)+in_count(j);
            i1 = i1+1;
        end
        if in_count(j) >= goal_count(i)
            Out(I==j) = i;
            j1 = j1+1;
            break;
        end
    end
end

Out = uint8(Out);


subplot(3,2,1),bar(0:255,goal_freq);
subplot(3,2,5),imhist(I);
subplot(3,2,2),bar(0:255,goal_sum_freq);
subplot(3,2,4),bar(0:255,g1s);


figure,imshow(Out);


