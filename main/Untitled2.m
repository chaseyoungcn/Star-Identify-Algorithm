
D=0.01;
[NumS,~]=size(K_vector);
Y1=star_lib_total(1);
[sss,~]=size(star_lib_total);
Yn=star_lib_total(sss);
% x = Y1:D:Yn;
% y = (x-Y1)/D;
x=Y1:D:Yn;
y=(x-Y1)/D+1;
y1=size(K_vector{y,1});
y1=y1(1,1);
scatter(x, y1,'filled')
% plot(y1,y1)
% scatter(x, y,sz,'filled')
% title('导航星分布示意图')
% xlabel('赤经/度')
% ylabel('赤纬/度')
%y1=size(K_vector{y,1})
%
% sz=15
% scatter(x, y1,sz,'filled')    
% title('导航星分布示意图')
% xlabel('赤经/度')
% ylabel('赤纬/度')
