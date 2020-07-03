function K_DATA = make_K_vector(data,n) %已无参数改动
[s1,s2]=size(data);
if s2~=3
    disp('星库不是三列的矩阵')
end
Y=data(:,3);%星库 所有角距信息
Y1=min(Y);
Yn=max(Y);
if Y1~=Y(1) || Yn~=Y(s1)
    disp('星库并未按角距值排序')
end
%n=s1;
%n=5000;%每0.01角距为一组 n是组数
% n=((Yn-Y1)/D )+1;
% n=floor(n);
global D;
D=(Yn-Y1)/(n-1);

K_DATA=cell(n-1,1);%K_DATA(i)=星角距在(Yi,Yi+D)内的星对儿矩阵  第i行 == Yi
for i=1:s1-1
    K_Rows=floor((data(i,3)-Y1)/D)+1; %向下取整 注意K_Rows 从1->n-1 即为 Y1 -> Yn-1  Yn(1<变量n<常量n-1)范围为()
    K_DATA{K_Rows,1}=[K_DATA{K_Rows,1};data(i,1:2)] ;%循环 将符合每个等级星角距范围的 星对儿 存入K_data的元胞中
end
K_DATA{n-1,1}=[K_DATA{n-1,1};data(s1,1:2)] ;
% disp('打印处于Y1等级下的星对儿:')
% disp(K_DATA{1,1})%打印处于Y1等级下的星对儿

end

%制作Y向量数据库  Y_name(i) Y1 -> Yn-1  一个标号代表一个区间  
%data放入 符合要求的星对儿（即星对儿编号 ），为 n X 2 矩阵
%实现伪代码 
%
% for i=1:s1-1
%     Y_name(i)="Y格式化输入i"; %一列字符串
% end
%计算Y(n)属于哪个区间 放入Y1 -> Yn-1
% for i=1:s1
%     (Y(i)-Y(1))/D=某值
%     值+1匹配 Y_name(i) 中Yi 第i行
%     Y_DATA(i)=[]   
%放入第i行的三维矩阵中 即     


