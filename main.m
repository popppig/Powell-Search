clc;
clear;
disp('Ŀ�꺯����y = x(1)^2+2*x(2)^2-4*x(1)-2*x(1)*x(2);');
[m,n]=Powell;
fprintf('���Ž�Ϊ:%f.\n',n);
fprintf('���Ž��Ӧ���Ա���Ϊ:x1=%f,x2=%f.\n',m(1),m(2));