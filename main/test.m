clear all;
close all;  %制作 某星库K向量并输出星对数目与星角距之间的关系图
clc
%         载入导航星库
load('星库_12_阈值分割_星对筛选.mat','star_lib_total');
%load('星库_20_阈值分割_双星融合_星对筛选.mat','star_lib_total');
% 载入(生成)K向量
% load('K_vector(星库12 阈值分割  D=0.01).mat','K_vector')

% 制作K向量
D=0.1;
[Yn,~]=size(star_lib_total);
n=((star_lib_total(Yn,3)-star_lib_total(1,3))/D)+1;%误差0.0002  分成500组 需要n=500+1
n=floor(n);
K_vector=make_K_vector(star_lib_total,n); %制作K向量查找表  可继续修改 分组数n=5000 ;K向量制作可手动
figure(1)
Star_a_d_pair(K_vector,star_lib_total,D)