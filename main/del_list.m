function A=del_list(A,ab1)%最好弄成随机删除  删除 重复第一列 的行(保留唯一)
A=sortrows(A,1);
for i=1:ab1
    SSS=find(A(:,1)==i);
    [S1,~]=size(SSS);%有多少个相同元素
    if S1>1  
        %随机选一行   
        baoliu_cols=randi(S1);              
        SSS(baoliu_cols)=[];
        A(SSS,:)=[];
    end
    
end

% a=A(:,1)


