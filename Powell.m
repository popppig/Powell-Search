%修正的Powell算法
%http://blog.csdn.net/shenziheng1/article/details/51088738 沈春旭
%步骤注释可参考工程最优化设计，第四章无约束最优化方法，4.5.3修正鲍威尔方法
function [Matrix,Value] = Powell
%--------------------------------Step1-------------------------------------
%设置初始迭代轮次k=1；迭代精度：Err；初始点；初始搜索方向组；
Err = 0.01;
X0 = [1,1];
Dir = [1,0;
       0,1];
num = 2; %2维
lun=1;%搜索轮次
while(1)
%----------------------------------Step2-----------------------------------
%第一轮：
    %沿着第一个方向进行一维搜索的得到相应的极值
    fprintf('第 %d 轮搜索\n',lun);
    [X(1,:),JZ(1)] = OneDimensionSearch(X0,Dir(1,:),Err);%返回极大值ExtremeVal，以及极大值对应的点ExtremePos
    %沿着第2到第num方向进行一维搜索
    for k = 2:num
        dir(k,:) = Dir(k,:);
        [X(k,:),JZ(k)] = OneDimensionSearch(X(k-1,:),dir(k,:),Err);
    end
    %构造新的搜索方向向量 并以X0为起点，沿此方向进行新一轮搜索，得到相应的极值
    dir(num+1,:) = X(num,:)-X0;
    [X(num+1,:),JZ(num+1)] = OneDimensionSearch(X0,dir(num+1,:),Err);
%----------------------------------Step3-----------------------------------
    %判断迭代终止条件
    delta = X(num+1,:)-X0;%收敛判断
    if( sqrt(sum(delta.*delta))<=Err )%点乘
        Matrix = X(num+1,:);
        Value = TextF(Matrix); %输出最优解和最优参数
        break;%跳过后续代码
    else
%----------------------------------Step4-----------------------------------
        MuInfoVal_0 = TextF(X0);
        %计算各个方向上的下降量
        Diff(1) = MuInfoVal_0-JZ(1);%此时我们在寻找极小值
        for k = 2:num
            Diff(k) =  JZ(k-1)-JZ(k);
        end
        %记录最下降量 以及 其出现的位置 求最大下降量
        [maxDiff,m] = max(Diff);
%----------------------------------Step5----------------------------------- 
       %计算映射点 求反射点
       Xmap = 2*X(num,:)-X0;
       %计算Powell特征值
       Val_0 = TextF(X0);%f1
       Val_1 = TextF(X(num,:));%f2
       Val_2 = TextF(Xmap);%f3
       %判断Powell条件 公式4-48
       if(Val_2>Val_0 && ...%f3<f1
          (Val_0-2*Val_1+Val_2)*(Val_0-Val_1-maxDiff)^2 < 0.5*maxDiff(Val_0-Val_2)^2 )%(f1-2*f2+f3)*(f1-f2-△m)^2<1/2*△m(f1-f3)^2
%----------------------------------Step6----------------------------------- 
       %如果满足,即为非线性相关 %设置下一轮搜索的初始点
       X0 = X(num+1,:);
       %替换m位置的搜索方向
       Dir(m,:) = dir(num+1,:);
%----------------------------------Step7----------------------------------- 
       else %如果不满足，即为线性相关，%保持原来的搜索方向，设置下一轮搜索始点
           if(Val_1 < Val_2)%f2<f3
               X0 = X(num,:);
           else
               X0 = X(num+1,:);
           end
       end 
    end 
    lun=lun+1;
end