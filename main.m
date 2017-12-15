clc;
clear;
disp('目标函数：y = x(1)^2+2*x(2)^2-4*x(1)-2*x(1)*x(2);');
[m,n]=Powell;
fprintf('最优解为:%f.\n',n);
fprintf('最优解对应的自变量为:x1=%f,x2=%f.\n',m(1),m(2));