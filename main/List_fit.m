function list_fit=List_fit(list1,list2)


if size(list1,1)==size(list2,1) && size(list1,2)==size(list2,2)
    %融合
    A=[list1(:,2),list2(:,2)];
    size(A,1)
    for i=1:size(A,1)
        if A(i,1)==-1
            if A(i,2)==-1
            else
               A(i,1)=A(i,2);
            end
        end
    end
    list_fit=[list1(:,1),A(:,1)];
    
else
    disp(['list1,2 error','fit不执行啦'])
    return;
    disp('fit不执行啦')
end
end