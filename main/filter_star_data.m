close all;
clear all; 
clc
load('附件2  简易星表.mat')
[d1 ,d2]=size(star_data);
global data_copy;
data_copy=[];

for i=1: d1    %阈值筛选
    if star_data(i,d2) <6
       data_copy=[data_copy;star_data(i,:)];
    end
end
figure('name','star_data')
plot_earth(star_data);
figure('name','data_copy')
plot_earth(data_copy);