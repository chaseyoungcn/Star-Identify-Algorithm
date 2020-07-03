syms a b c; %星敏感器的三个姿态角 要求的量
syms a1 b1 a2 b2 a3 b3; %赤经和赤纬的三组坐标
syms f;% 焦距                                     %%%%有问题 大问题  写公式需要修改
syms q1 q2 q3;% 图像坐标点到o点的距离
M1 =[ sin(a)*cos(c)-cos(a)*sin(b)*sin(c),-cos(a)*cos(c)-sin(a)*sin(b)*sin(c),cos(b)*sin(c);
   -sin(a)*sin(c)-cos(a)*sin(b)*cos(c),cos(a)*sin(c)-sin(a)*sin(b)*cos(c),cos(b)*cos(c);
   cos(a)*cos(b),sin(a)*cos(b),sin(b)]; %定义天球坐标系到星敏感器下的转换矩阵

XS1 = [cos(a1)*cos(b1); sin(a1)*cos(b1);sin(b1)]; %天球坐标系下的坐标
XST1 = M1*XS1; %在星敏感器坐标系下的坐标
z1 = XST1(3); %星敏感器下的z坐标
M21 = 1/z1 * [f, 0 , 0; 0 ,f , 0]; % 从星敏感器到图像坐标系下转换矩阵
X1 = M21 * XST1; % 相机坐标系下的坐标

XS2 = [cos(a2)*cos(b2); sin(a2)*cos(b2);sin(b2)]; 
XST2 = M1 * XS2;
z2 = XST2(3); %星敏感器下的z坐标
M22 = 1/z2 * [f, 0 , 0; 0 ,f , 0]; % 从星敏感器到图像坐标系下转换矩阵
X2 = M22 * XST2; % 相机坐标系下的坐标

XS3 = [cos(a3)*cos(b3); sin(a3)*cos(b3);sin(b3)]; 
XST3 = M1 * XS3;
z3 = XST3(3); %星敏感器下的z坐标
M23 = 1/z2 * [f, 0 , 0; 0 ,f , 0]; % 从星敏感器到图像坐标系下转换矩阵
X3 = M23 * XST3; % 相机坐标系下的坐标

% 目标函数的设定
c1 = (sqrt(X1(1)^2 + X1(2)^2) - q1) + (sqrt(X2(1)^2 + X2(2)^2) - q2)+(sqrt(X3(1)^2 + X3(2)^2) - q3);
c2 = (X1(1)^2 + X1(2)^2) - q1^2 + (X2(1)^2 + X2(2)^2) - q2 ^2 +  (X3(1)^2 + X3(2)^2) - q3 ^2
% 对目标函数在约束条件下优化求解得a，b，c三个量
% 查阅资料可知，f的值一般为50mm左右，f^2的 值为，因此目标函数c可以简化为。。。，因此对简化后的c有优化为


 



