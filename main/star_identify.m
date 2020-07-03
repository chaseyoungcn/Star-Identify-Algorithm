%star_identify.m
clear all
clc
close all;
%匹配的观测三角形不全
global K_vector;
global star_lib_total;
global b_cell;

%载入对个文件
readxls; %b_cell为读取的每个文件num_of_files,filename_1

%载入导航星库
% load('星库_12_阈值分割_星对筛选.mat','star_lib_total'
% 载入(生成)K向量
% load('K_vector(星库12 阈值分割  D=0.01).mat','K_vector')

%制作K向量
% [Yn,~]=size(star_lib_total);
% n=((star_lib_total(Yn,3)-star_lib_total(1,3))/0.01)+1;%误差0.0002  分成500组 需要n=500+1
% n=floor(n);
% K_vector=make_K_vector(star_lib_total,n); %制作K向量查找表  可继续修改 分组数n=5000 ;K向量制作可手动

global D;
D=0.001;
% load('K_test_12双星.mat','K_vector')

list_final=[];
for i=1:num_of_files
    i=8;
    if i>0 &&i<7            %按条件
                            %载入12du导航星库
        load('星库_12_阈值分割_星对筛选.mat','star_lib_total')
                            % 载入(生成)K向量
        load('K_vector(星库12 阈值分割  D=0.01).mat','K_vector')%
        D=0.01;
        N=512;
        FOV=12;
%         mm=mm+1;
    else
        %载入20du导航星库  改一改名字吗 做一下K向量嘛...
        load('星库_20_阈值分割_双星融合_星对筛选.mat','star_lib_total')    
        % 载入(生成)相应K向量
        load('K_vector(星库20_阈值分割_双星融合_星对筛选  D=0.007).mat','K_vector')
        N=1024;
        FOV=20;
        D=0.007;
%         nn=nn+1;
    end


          List=matching(filename_all{i,1},N,FOV);%filename{i,1}%%这里再改改  还有  20度的情况  在写个if
%           List_1=List;
          %List_2=List;
     for jj=1:10000      
         if isempty(find(List(:,2)==-1)) %无-1时            
             break;
         else
              List_1=matching(filename_all{i,1},N,FOV);
              List=List_fit(List,List_1);
         end        
     end
        
    SL=size(List,1);
    List_cell=cell(SL,2);
    for ii=1:SL  %替换成功  得到List_cell
        List_cell{ii,2}=List(ii,2);
        List_cell{ii,1}=b_cell{List(ii,1),1};
    end
    list_final=[list_final;List_cell];
end


%循环计算每一文件匹配List(已转换为完成的 符号+标号)
%存到细胞数组
%打印完成

% 9.23  11.27  
%20星库制备 bingo
%未完待续 
%其他图

