 %画出赤经赤纬图
 %输入数据 第二三列为赤经赤纬
function   plot_earth(data)
X = data(:,2);
Y = data(:,3);
sz = 15;
scatter(X, Y,sz,'filled')    
grid on;
set(gca,'GridLineStyle','-','GridColor','k','GridAlpha',1);%
title('导航星分布示意图')
xlabel('赤经/度')
ylabel('赤纬/度')
end