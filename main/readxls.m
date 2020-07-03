
getfilename=ls('C:\Users\Chase\matlab\xingtu*.xls'); %取目录下所有excel文件的文件名(.xls或.xlsx)
filename_all = cellstr(getfilename); %将字符型数组转换为cell型数组
num_of_files = length(filename_all); %excel文件数目
 for i=1:num_of_files %循环读入excel数据并存入结构体database中     
 database(i) = struct('Name',filename_all(i),'Data',xlsread(filename_all{i}));

 end
%注:该脚本将所有的excel数据读入到变量database中，database向量的每个元素为一结构，该结构由文件名Name和文件中的数据Data组成，
%具体访问第i个excel数据的方法为：
%a=database(1).Data;
