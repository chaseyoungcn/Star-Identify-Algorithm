%matching 参数应为文件名
function List=matching(filename,N,FOV)
%  Obser为         1 2 3                 4 5 6
%                 S1 S2 S3            S12 S13 S23
%                                    利用角距在K里寻找坐标 可认为s12=a12
%         若匹配成功S1=A1;S2=A2,S3=A3一一对应
%            (三角形编号S即b_cell行号)    (三个角距)
%
%            b_cell为xls文件全部+第四列[MAX1,~]=size(b_cell);

% global Fail_star_map;
% global Fsm_sum;
Obser=Observe3(N,FOV,filename);%测试的某个文件

[s1,s2]=size(Obser);
% s1=s1
Fail=[];
Succ=[];
List=[];
match_3_fail=0;
% for j=1:1000000
%     Fail_FLAG=0;
Fail_FLAG=0;
    for i=1:s1% 这里S1是观测三角形 个数
%         Fail_FLAG=0;
        if match_3_fail<=0.8*s1 %若匹配三角形失败次数 该星图匹配失败            %WARNING 挑选观测三角形时如何停止   
            SB=Obser(i,4:6);%本来S12能够找到准确S1 S2 这里最好只找到A1 A2
%           SB1=Obser(i,1:3);%重新算Si检
            S12=SB(1);
            S13=SB(2);
            S23=SB(3);            
            A1A2=search_K(S12); %A_sum里含有猜测的A1 A2坐标
            A1A3=search_K(S13);%
            A2A3=search_K(S23);
            if isempty(A1A2)||isempty(A1A3)||isempty(A2A3) %角距链表不能为空,此三角形未匹配到
                match_3_fail=match_3_fail+1;
                continue;
            end
            Sm= match_L1_L2(A1A2,A1A3,A2A3);  %直接获得匹配坐标 可能好几组  A1 A2 A3                   
            if size(Sm,1)>=2
                SB1=Obser(i,1:3);
                Sm=Pyramid(SB1,Sm);%加个金字塔筛选 
            end
            if ~isempty(Sm)%单个%匹配成功
                SSB=Obser(i,1:3);%匹配成功的那些b_cell行号
%                 size(Sm);
                S=[SSB,Sm];
                Succ=[Succ;S]; %n*6
                %加入Succ=[]            
            else
                match_3_fail=match_3_fail+1;%这一组未成功
                continue;
            end
        else
            Fail_FLAG=1; 
            break;
            %filename
            %disp('该星图匹配失败!')
            %Fail=[Fail;filename,0]
            %存入 全局变量Fail 
            %该星图匹配失败 编号星
        end      
%             %%%%%导出星图匹配失败星图
%             AAAAA='匹配失败!'%该星图
%             Fail_FLAG=1;
%              dddd=struct('Name','State');   %****
%              %Fail_star_map(Fsm_sum) =struct('Name',filename,'State',AAAAA);
% %             Fsm_sum=Fsm_sum+1;
%             break;
%             Fail_star_map=[Fail_star_map;filename,disp('该星图匹配失败!')]                
    end

    
[List1,List2]=size(Succ);

%  if List2~=6
%      sprintf([filename,'居然一个也没匹配上']);
%  end
 
%Fail 与Succ互为补集

        
for i=1:3
    if  List2~=0
        S=[Succ(:,i),Succ(:,i+3)];
        List=[List;S];
    end
end
if ~isempty(List)
    Su=List(:,1);%匹配成功的星星
end
global b_cell; 
[sb1,~]=size(b_cell); 

for i=1:sb1
    Fail=[Fail;i];
end
% Fail=Fail%
% a=Fail_FLAG%

%假设星图匹配失败
if Fail_FLAG==1
    %List=[];%清空之前单个匹配的 %我要成功率     所以不可以有匹配失败
    Fail=Fail;
else
    %否则保留    
    Fail=setxor(Fail,Su);    
end

[SF,~]=size(Fail);
for i=1:SF
    S=Fail(i,1);%给失败的星星 -1
    SSS=[S,-1];
    List=[List;SSS];
end
List=del_list(List,sb1);
%  删除第一列相同元素及其对应的行  星图里有sb1个星星
%  find(List(:1)==)
%List 每个观测星 对应星库编号
     
end