%% һά��������:���ûƽ�ָ %%
%http://blog.csdn.net/shenziheng1/article/details/51088738
function [ExtremePos,ExtremeVal] = OneDimensionSearch(x1,Dir,err)
% ��X0�㿪ʼ,��������
% Dir:�����ķ���
% err:�ƽ�ָ��ֹͣ�����ľ��ȡ�
% ���ؼ���ֵExtremeVal���Լ�����ֵ��Ӧ�ĵ�ExtremePos
%------------------------Step1�����˷�ȷ������------------------------------
%����x1,ǰ��������x2
y1 = TextF(x1);
x2 = x1+Dir;
y2 = TextF(x2);
%��Сֵ����֧�ж�
if y1 < y2 % ��֧
    Dir = -Dir;
    temp = x1;
    x1 = x2;
    x2 = temp;
    x3 = x2+Dir;
    y3 = TextF(x3);
else %��֧ ������������
    Dir = 2*Dir;
    x3 = x2+Dir;
    y3 = TextF(x3);
end
while(1) 
    if (y2<=y3) %���ּ�Сֵ���ڵ�����
        a = min(x1,x3);
        b = max(x1,x3);
        break;
    else
        x1 = x2;
        x2 = x3;
        y2 = y3;
        x3 = x2+Dir;
        y3 = TextF(x3);
    end
end
%--------------------------Step2���ƽ�ָ�----------------------------------
g1 = 0.382; g2 = 0.618;
xx1 = a+g1*(b-a);
yy1 = TextF(xx1);
xx2 = a+g2*(b-a);
yy2 = TextF(xx2);
delta = sqrt(sum(abs(b-a).*abs(b-a)));
while( delta>=err)
    if(yy1 < yy2)
        b = xx2;
        xx2 = xx1;
        yy2 = yy1;
        xx1 = a+g1*(b-a);
       yy1 = TextF(xx1);
    else
        a = xx1;
        xx1 = xx2;
        yy1 = yy2;
        xx2 = a+g2*(b-a);
        yy2 = TextF(xx2);
    end   
    delta = sqrt(sum(abs(b-a).*abs(b-a)));
end
ExtremePos = 0.5*(a+b);
ExtremeVal = TextF(ExtremePos);