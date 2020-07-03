function A_sum = search_K(A12)      %输入角距,返回匹配坐标列表
global K_vector;%%到时候这两个都会保存下来  不需要全局变量
global star_lib_total;%用星库做的K_vector
%Error=0.002;
[K1,K2]=size(K_vector);

if K2~=1
    disp('K error')
end
global D;
iii=star_lib_total(1,3);
i=(A12-iii)/D ;
i= floor(i)+1;

%%%范围考虑下
[~,kk2]=size(K_vector{i,1});

% if kk2~=2
%     disp('kk2 error')
% end

A_sum=K_vector{i,1};
% if i~=K1
%    A_sum=[K_vector{i,1};K_vector{i+1,1}]; 
% else
%    A_sum=K_vector{i,1};
% end

end

