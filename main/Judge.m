function Flag_linear= Judge(c) %直线Flag_linear=1 不是直线Flag_linear=0
global b_cell;
Angle_error=1;%假定角度误差为1度
% b_cell{c(1),4};   %为 第j k L颗星星在性敏感的单位向量
% b_cell{c(2),4};
% b_cell{c(3),4};
vv1=b_cell{c(2),4}-b_cell{c(1),4};
vv2=b_cell{c(3),4}-b_cell{c(1),4};
al=acos(dot(vv1,vv2)/(norm(vv1)*norm(vv2)));
al=al/pi*180;
if (al>=0 && al<0+Angle_error)||(al>180-Angle_error && al<=180)
    Flag_linear=1;
else
Flag_linear=0;
end
end

