function ob3= random_select(s1)  %无参数改动
ob3=[];
Flag_ob3=0;
%随机选择->判断是否在一条直线上->若是 失败值+1 进入下一次循环
%                              ->不是的->监测任意两个编号/这句话把我搞麻烦了,干脆都不重复然后lack掉的再加上重复的星//
%                                           ->如果已存在则删除  
%                                           ->否则存储到一个矩阵中
%得到若干组检测三角形 三角形的三个点的行号存储在ob3内  一行 一个三角形
Warning=0;%随机数匹配限值
    while Warning~=10000
          Pass=0;
          random_sum=randperm(s1,3);          
          j=random_sum(1);
          k=random_sum(2);
          L=random_sum(3);
          c=sort([j,k,L]);
          %判断星敏感坐标 是否贼一条直线上如果是 则break;
          if Judge(c)==1
%               break;
             continue;
          end
          Secelt=0;%当不在一条直线上时

                    if Flag_ob3==1 %如果不是第一次运行  不重复则secelt=1
                        for i=1:ob3s1
                            re_sum=0;%一个也不重复 re_sum=1;%重复1个 
                            if size(find(ob3(i,:)==c(1)),2)>re_sum 
                                Pass=Pass+0.5;
                            end
                            if size(find(ob3(i,:)==c(2)),2)>re_sum 
                                Pass=Pass+0.5;
                            end
                            if size(find(ob3(i,:)==c(3)),2)>re_sum
                                Pass=Pass+0.5;
                            end
                            if  Pass>0.5*re_sum        %重复1个PASS=0.5 一个也不重复pass=0
%                                Pass=0;
                                Warning=Warning+1;%Secelt=0;
                                break; %打破监测重复函数的循环,进入下一步随机数生成状态  
                            end
                        end
                        Secelt=1;      %一个也不重复          
                    else  %第一次运行
                        ob3=[ob3;c];
                        Flag_ob3=1;
                        [ob3s1,~]=size(ob3);
                    end
                        
                    %break位
           if Secelt==1 %结束条件 ob3无重复的c
              ob3=[ob3;c];
              [ob3s1,~]=size(ob3);  
              if ob3s1==s1%floor(s1/3)+5  %限制三角形  10个三角形就30个点 
                 Warning=10000; 
              end    
           end
                    
                    
    end%挑选多组三角形
 %已跳出warning
    ob3_rows=ob3(:);%列向量%有很多
    ob3_rows=unique(ob3_rows,'rows');
    all_cols=[];
    for i=1:s1
        all_cols=[all_cols;i];
    end
    lack_star=setxor(ob3_rows,all_cols);
    [l_s_s1,~]=size(lack_star);
    if l_s_s1==1
       j=lack_star(1,1);
       for i=1:100000
           k=randi(s1);
           for m=1:100000
                if k==j
                   k=randi(s1);
                   continue;
                end
                break;
           end       
           L=randi(s1);
           for ssb=1:100000
                if L==j|| L==k
                   L=randi(s1);
                   continue;
                end
                break;
           end                              
           c=sort([j,k,L]);
           if Judge(c)~=1
              break;
           end%判定直线           
       end
       ob3=[ob3;c];%通过则加入ob3
    end
    
    if l_s_s1==2 %%
       j=lack_star(1,1);
       k=lack_star(2,1);
       for i=1:10000
           L=randi(s1);
           for ssc=1:100000
                if L==j|| L==k
                   L=randi(s1);
                   continue;
                end
                break;
            end     
                    
           c=sort([j,k,L]);
           if Judge(c)~=1
              break;
           end
       end
       ob3=[ob3;c];
    end         %%
    if l_s_s1>=3
        disp('出错,lack star多于3')
    end
    %获取的ob3存储了观测三角形的行号
    %查询ob3所有元素(此时为不重复)与1:s1中的差值
    
end

