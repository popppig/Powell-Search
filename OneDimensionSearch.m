%% 一维搜索函数:采用黄金分割法 %%
%http://blog.csdn.net/shenziheng1/article/details/51088738
function [ExtremePos,ExtremeVal] = OneDimensionSearch(x1,Dir,err)
% 从X0点开始,进行搜索
% Dir:搜索的方向。
% err:黄金分割的停止搜索的精度。
% 返回极大值ExtremeVal，以及极大值对应的点ExtremePos
%------------------------Step1：进退法确定区间------------------------------
%计算x1,前进，计算x2
y1 = TextF(x1);
x2 = x1+Dir;
y2 = TextF(x2);
%最小值左右支判断
if y1 < y2 % 右支
    Dir = -Dir;
    temp = x1;
    x1 = x2;
    x2 = temp;
    x3 = x2+Dir;
    y3 = TextF(x3);
else %左支 扩大搜索步法
    Dir = 2*Dir;
    x3 = x2+Dir;
    y3 = TextF(x3);
end
while(1) 
    if (y2<=y3) %发现极小值所在的区间
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
%--------------------------Step2：黄金分割----------------------------------
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