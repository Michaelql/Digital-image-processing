clear

%对第一个图像进行直方图均衡化，得到sk
I1=imread('pout.tif');
[m1,n1]=size(I1);
r=zeros(1,256);
for i=1:m1
    for j=1:n1
        k=I1(i,j);
        r(k+1)=r(k+1)+1;
    end
end
pr=zeros(1,256);
for i=1:256
    pr(i)=r(i)/(m1*n1);
end
sum_pr = cumsum(pr);
sk = uint8((256-1) .* sum_pr); 
%对另一个图进行直方图均衡化，得到vk
I2=imread('cameraman.tif');

[m2,n2]=size(I2);
z=zeros(1,256);
for i=1:m2
    for j=1:n2
        k=I2(i,j);
        z(k+1)=z(k+1)+1;
    end
end
pz=zeros(1,256);
for i=1:256
    pz(i)=z(i)/(m2*n2);
end
sum_pz = cumsum(pz);
vk = uint8(255.*sum_pz);
%遍历sk和vk，寻找sk与vk最接近的点，并构成映射关系
for i=1:256
    e=255;
    for j=1:256
        minv=abs(sk(i)-vk(j));
        if minv<e
            k=j;
            e=minv;
        end
    end
    svk(i)=vk(k);
end
imgn = uint8(zeros(m1, n1));  
for i = 1 : m1
   for j = 1 : n1
      imgn(i,j) = svk(I1(i,j));
   end
end

figure,subplot(311),imhist(I1);
subplot(312),imhist(I2);
subplot(313),imhist(imgn);

figure,subplot(1,2,1),imshow(I1);
subplot(1,2,2),imshow(imgn);




