clc;
clear;
% 由星图文件可知，给定点的坐标应该是原点在左上角的坐标，但是我们所假定的坐标原点在感光面中心处，因此对数据做减去256的操作即可
a = xlsread("xingtu01.xls");
a = a-256;
[n1, n2] = size(a);
b = [];
for i = 1: n1
    for j = i + 1: n1
        for k = j + 1: n1
            b = [b;i,j,k];
        end
    end
end
[n3, n4] = size(b);
b2 = [];
for i = 1 : n3
    dian1 = b(i,1);
    dian2 = b(i,2);
    dian3 = b(i,3);
    s1 = [a(dian1,1),a(dian1,2)];
    s1 = s1 ./ norm(s1,2);
    coss1 = s1(1);
    acoss1 = rad2deg(acos(coss1));
    s2 = [a(dian2,1),a(dian2,2)];
    s2 = s2 ./ norm(s1,2);
    coss2 = s2(1);
    acoss2 = rad2deg(acos(coss2));
    s3 = [a(dian3,1),a(dian3,2)];
    s3 = s3 ./ norm(s1,2);
    coss3 = s3(1);
    acoss3 = rad2deg(acos(coss3));
    % 三个角度差小于等于6度则认为是一条直线上
    if (abs(acoss1 - acoss2) + abs(acoss2 - acoss3) + abs(acoss3 - acoss1)) > 6
        b2 = [ b2;dian1,dian2,dian3];
    end
end