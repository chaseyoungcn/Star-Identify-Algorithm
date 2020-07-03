function Sm_1=Pyramid(ScB1,Sm)%传送n组 返回一组或空
%ScB1是观测三角形 即 星图中的编号 较小
%Sm为其对应的导航星库中的编号 一一对应
global b_cell;
% global star_lib_total;
[z1,z2]=size(Sm);
B1=ScB1(1);
B2=ScB1(2);
B3=ScB1(3);
Sm_1=[];
% for zz=1:z1
%随机匹配一行 
for i=1:1000000
    Flag=0;
    zz=randi(z1);
    SB1=Sm(zz,:);
    %循环 
    S1=SB1(1);%估计值
    S2=SB1(2);
    S3=SB1(3);%已知的
    [s1,~]=size(b_cell); 
    S_jian=randi(s1);%检查星 从星库里找一个
    
    for m=1:100000
        if S_jian==B1 || S_jian==B2 || S_jian==B3
            S_jian=randi(s1);
            continue;
        end
        break;
    end
    S1j=jiaoju_huduzhi(b_cell{B1,4},b_cell{S_jian,4});  %从星库 赵德志
    S2j=jiaoju_huduzhi(b_cell{B2,4},b_cell{S_jian,4});
    S3j=jiaoju_huduzhi(b_cell{B3,4},b_cell{S_jian,4});
    %S123J=[S1j,S2j,S3j];%三个角距
    S1AJ  = search_K(S1j); %%应为B1AJ
    S2AJ = search_K(S2j); 
    S3AJ  = search_K(S3j) ;
    J= search_list(S1,S1AJ);%寻找B1对应的s1  i
    if ~J  %如果J=false即 未search到
        continue;
    end        
    s2j=[S2,J];
    s2j=sort(s2j);
    Flag=Flag+ismember(s2j,S2AJ,'rows');
    %寻找S2AJ中有无
    s3j=[S3,J];
    s3j=sort(s3j);
    Flag=Flag+ismember(s3j,S3AJ,'rows');
    %寻找S3AJ中有无
    
    %通过则退出
    if Flag==2%匹配上
        Sm_1=SB1;
        break;
    end
    %通过则退出
end
%%%%%%%%%%%%   
% SB1=Sm(1,:);%如果flag=2则说明金字塔匹配成功
% SB2=Sm(2,:);
% S1=SB1(1);
% S2=SB1(2);
% S3=SB1(3);
% [s1,~]=size(b_cell); 
% S_jian=randi(s1);%检查星
% for m=1:100000
%     if S_jian==S1 || S_jian==S2 || S_jian==S3
%         S_jian=randi(s1);
%         continue;
%     end
%     break;
% end
% S1j=jiaoju_huduzhi(b_cell{S1,4},b_cell{S2,4});
% S2j=jiaoju_huduzhi(b_cell{S1,4},b_cell{S3,4});
% S3j=jiaoju_huduzhi(b_cell{S2,4},b_cell{S3,4});
% %S123J=[S1j,S2j,S3j];%三个角距
% S1AJ  = search_K(S1j); 
% S2AJ = search_K(S2j); 
% S3AJ  = search_K(S3j) ;
% J= search_list(S1,S1AJ);
% s2j=[S2,J];
% s2j=sort(s2j);
% Flag=Flag+ismember(s2j,S2AJ,'rows');
% %寻找S2AJ中有无
% s3j=[S3,J];
% s3j=sort(s3j);
% Flag=Flag+ismember(s3j,S3AJ,'rows');
% %寻找S3AJ中有无
% if Flag==2
%     Sm_1=SB1;
% else
%     Sm_1=SB2;
%%%%%%%%%%%%
end