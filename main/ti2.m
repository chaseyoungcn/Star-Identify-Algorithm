close all;
clear all;           %%%%双星融合   有时间再弄20度的
clc
load("附件2  简易星表.mat")%_双星融合_导航星制作.
% global double_star;

%  n=1;
%  f=12;                       %%%%双星融合   有时间再弄20度的
%  N=512;
  n=2;
 f=20;                       %%%%双星融合   有时间再弄20度的
 N=1024;

 
[d1, d2] = size(star_data);
star_data_1 = zeros(d1,d2+1); % 包含有方向余弦信息的星表

figure('name','star_data')
plot_earth(star_data);
%scatter(star_data(:,2),star_data(:,3),sz,'filled');
% 将星表转换为方向余弦加星表的形式
 for i = 1 : d1
     star_data_1(i,1) = star_data(i,1);
     star_data_1(i,2) = cos(star_data(i,2))*cos(star_data(i,3));
     star_data_1(i,3) = sin(star_data(i,2))*cos(star_data(i,3));
     star_data_1(i,4) = sin(star_data(i,3));
     star_data_1(i,5) = star_data(i,4);
 end

 d = sqrt(2) * n * f / N;
 for i = 1 :d1
     if i ~= star_data_1(i,1)
         continue
     else
         for j = i+1 : d1
             if j~= star_data_1(j,1)
                 continue
             else
                 si = [star_data_1(i,2), star_data_1(i,3),star_data_1(i,4)];
                 sj = [star_data_1(j,2), star_data_1(j,3),star_data_1(j,4)];
                 dist = acos(sum(si.*sj)/(norm(si,2) * norm(sj,2)));
                 if dist < d 
                     m1 = star_data_1(i,5);
                     m2 = star_data_1(j,5);
                     dist1 = dist / (1+ exp((m1 - m2)/2.5));
                     dist2 = dist - dist1;
                     s = (si * dist1 + sj * dist2) / sin(dist);
                     star_data_1(i,1) = i;
                     star_data_1(i,2) = s(1);
                     star_data_1(i,3) = s(2);
                     star_data_1(i,4) = s(3);
                     star_data_1(i,5) = m1 - 2.5*log10(10^((m1-m2)/2.5) + 1);
                     star_data_1(j,1) = i;
                     star_data_1(j,2) = s(1);
                     star_data_1(j,3) = s(2);
                     star_data_1(j,4) = s(3);
                     star_data_1(j,5) = m1 - 2.5*log10(10^((m1-m2)/2.5) + 1);
                     break;
                 end
             end
         end
      end  
 end
star_data_2 = [];
for i = 1:d1
    if i == star_data_1(i,1)
        star_data_2 = [star_data_2;star_data_1(i,:)];
    end
end
star_data_3 =[]; % 筛选过星等后的星表
[d3,d4] = size(star_data_2);
 for i = 1: d3
     if star_data(i,d2) < 6
         star_data_3 = [star_data_3;star_data_2(i,:)];
     end
 end
[d5, d6] = size(star_data_3);
star_star = zeros(d5,d6-1);
for i = 1: d5
    Flag=0;
    star_star (i,1) = star_data_3(i,1);
    for j=1:d1
        if star_star(i,1)==star_data(j,1)
           Flag=1;
           star_star (i,2:3)=star_data(j,2:3);                   
        end
    end 
    if Flag==0
        disp('纳尼,居然在原表中未找到标号!')
    end
    star_star (i,4) =  star_data_3(i,5);
end
double_star=star_star;
figure('name','double_star');
plot_earth(double_star);

              

     