function Obser=Observe3(N,FOV,filename) %得到三个角距
global b_cell;     %%坐标正常
% [~,~,b_cell]=xlsread('xingtu01.xls'); %举例打开某个文件   %b为cell  
[~,~,b_cell]=xlsread(filename);
pixel_size=25*(1e-3);
% N=512; %像素数  !!记得更改       %图像坐标系 转换为 星敏感
f=(N*pixel_size)/(2*tand(FOV/2));%fov为度

[s1,~]=size(b_cell); %b  3 X 3

for i=1:s1  %图像坐标系 转换为 星敏感 %b_cell第四列为每个点的星敏感方向向量 不再归一化
    b_cell{i,4}=[(b_cell{i,2}-N/2)*pixel_size;
            (b_cell{i,3}-N/2)*pixel_size;
            -f];%b cell第四列为每个点的星敏感坐标
     
end

Obser=random_select(s1); %取得观测三角形  n x 3矩阵
[size1,~]=size(Obser);
A=[];
for i=1:size1
    S1=Obser(i,1);
    S2=Obser(i,2);
    S3=Obser(i,3);
    S12=jiaoju_huduzhi(b_cell{S1,4},b_cell{S2,4});
    S13=jiaoju_huduzhi(b_cell{S1,4},b_cell{S3,4});
    S23=jiaoju_huduzhi(b_cell{S2,4},b_cell{S3,4});
    A=[A;S12,S13,S23];%三个角距
end
[sizeA1,sizeA2]=size(A);
if sizeA1~=size1 && sizeA2~=3
    disp('A阵出错');
end
Obser=[Obser,A];%这样一来  Obser为         1 2 3                 4 5 6
                %                 (三角形编号即b_cell行号)     (三个角距)
                %                  B_cell为xls文件全部+第四列
          
end