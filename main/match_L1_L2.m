function Sm= match_L1_L2(L1,L2,L3)  %无误
%返回Sm,为S123所对应;
[n1,~] = size(L1);
[n3,~] = size(L2);
Sm=[];%%%%最多两组匹配上
Flag=0;
Flag_nei=0;
for i = 1:n1
    for j = 1: n3  %如果有多组解用第一组
        L = [L1(i,:) L2(j,:)];
        L_before=L1(i,:);
        L_after=L2(j,:);
        [~,n6] = size(L);
        if n6~=4
            disp('输入链表有误')
        end
        for k = 1: 2 %查找重复
            x = L(k);
            
            if size(find(L == x),2) ==2 %>1 如果有重复  有公共点             
               A1 = x;
               A2 = L_before(find(L_before~=x ));
               A3 = L_after(find(L_after~=x ));
                %查L3里是否有 判定A2 A3
                A_L3=sort([A2,A3]);
                if L_search(A_L3,L3)
                    Flag=1;
                    Flag_nei=1;
                    %若匹配上
                    %待补充
                    
                   break;
                end
                            
            end
        end
        if  Flag_nei==1
            Flag_nei=0;
            
            break;
        end
    end
    if Flag==1
        Sm=[Sm;A1,A2,A3];%%
        
        Flag=0;
    end

end

