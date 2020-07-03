function view_in_six= Search(Xlmin,Xlmax,Ylmin ,Ylmax,data)
%global data_copy;
%[d1,d2]=size(data_copy);%双星合成后数据，待处理
% data=load('阈值分割_双星融合_导航星.mat');
% double_star=data.star_data_4;%%每个都要改 心累
double_star=data;
%global double_star;%利用双星融合数据  %=data_copy;%暂用阈值分割玩的数据处理
%利用已制作导航星库
[d1,d2]=size(double_star);%双星合成后数据，待处理
%目前先手动替换
view_in=[];
for m=1:d1
    if double_star(m,2)>Xlmin && double_star(m,2)<Xlmax
        if double_star(m,3)>Ylmin && double_star(m,3)<Ylmax
            view_in=[view_in;double_star(m,:)];%某随机视场内所有导航星
%           disp('我来了')            
        end
    end           
end
[ov,pv]=size(view_in);
% ov
% pv
view_in_six=[];
if ov==0 || pv==0 % view_in=[]时
%    disp('当前随机视场无导航星')
    
else
    view_in_sort=sortrows(view_in,d2);%按星等排序  %4,d2
    [o,~]=size(view_in_sort);
%    view_in_six=[];
    if o>6
        o=6;
    end    
    view_in_six=[view_in_six;view_in_sort(1:o,:)];%取星等前六的导航星
end
% for i=1:ov
%     view_in(i,4)=view_in(i,4)*10;
% end
% 
% view_in_sort=sortrows(view_in,4);%按星等排序  %4,d2


end

