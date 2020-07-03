clear all;
clc
close all;
FOV=20;%视角 
%用随机视场做星对筛选
%function random_view(FOV)%随机视场  选最亮的前6个星   星库制备
tic %时间起始
view=FOV;
star_star=[];
star_lib_total=[];
data=load('导航星_20_阈值分割_双星融合.mat'); 
data=data.star_star;%做哪个数据的星库?
for i =1 :1000000
    %W=rand(2,1,'single'); %Yr=W(2);
    %一组坐标,某随机视场中心//(选择这个)也可以在左下角//（Xr,Yr），随机范围在赤经=（0+view/2,360-view/2),赤纬=(-90+view/2,90-view/2)
    Xr=rand*(360-view)+view/2;
    Yr=( -1 + (1+1).*rand )*(90-view/2);    
    Xlmin=Xr-view/2;
    Xlmax=Xr+view/2;
    %Yl=(Yr-view/2,Yr+view/2);
    Ylmin=Yr-view/2;
    Ylmax=Yr+view/2;%恢复坐标所在视场范围
    star_lighting=Search(Xlmin,Xlmax,Ylmin ,Ylmax,data);%寻找区域内满足范围的星星，并按亮度高低返回六个导航星信息
    star_lib=star_lib_make(star_lighting);%制作视场内六颗星 星库 赋值给矩阵star_lib  即星对儿筛选     
    star_lib_total=[star_lib_total;star_lib];
    star_lib_total=unique(star_lib_total,'rows'); %制作总星对库 编号（小） 编号（大） 角距值
    star_star=[star_star;star_lighting];%所有的导航星
    star_star=unique(star_star,'rows');%存储到一个全新矩阵，删除重复
end
star_lib_total=sortrows(star_lib_total,3);%按星角距从小到大排序
[Yn,~]=size(star_lib_total);
% n=(star_lib_total(Yn,3)-star_lib_total(1,3))/0.0002;%误差0.0002
% n=floor(n);
% K_vector=make_K_vector(star_lib_total,n); %制作K向量查找表  可继续修改 分组数n=5000 ;K向量制作可手动
plot_earth(star_star)% 将所有导航星 未知矩阵 展示为 二维散点图
toc %计时停止
%end

% (处理简易星表)12(20du)       导航星个数(star_star) 导航星对儿数(star_lib_total)   星库大小
%阈值分割+星对筛选法               3885(1881)           45304(21492)                 512KB(247KB)    
%阈值分割+双星融合+星对筛选	       3022(1717)           33583(19798)                 328KB(227KB)
%阈值分割+双星融合                 3280
%阈值分割                          4856
%未经处理的建议星表                4908