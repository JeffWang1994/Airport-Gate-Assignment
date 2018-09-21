%% logistic 回归方法 MATLAB实现程序
% 第3章 数据建模及MATLAB实现
%------------------------------------------------
%% 数据准备
clear all
clc
X0 = xlsread('logistic_ex1.xlsx','B2:D21'); % 回归数据X值
XE = xlsread('logistic_ex1.xlsx','B2:D26'); % 验证与预测数据
Y0 = xlsread('logistic_ex1.xlsx','E2:E21'); % 回归数据P值
%------------------------------------------------
%% 数据转化和参数回归
n = size(Y0,1);
%Y1 = Y0;
for i = 1:n
    if Y0(i) == 0
        Y1(i,1)=0.25;
    else
        Y1(i,1)=0.75;
    end
end
X1 = ones(size(X0,1),1); % 构建常数项系数
X = [X1,X0];
Y = log(Y1./(1-Y1));
b = regress(Y,X);
%------------------------------------------------
%% 模型验证和应用
for i = 1:size(XE,1)
    Pai0 = exp(b(1)+b(2)*XE(i,1)+b(3)*XE(i,2)+b(4)*XE(i,3))/(1+exp(b(1)+b(2)*XE(i,1)+b(3)*XE(i,2)+b(4)*XE(i,3)));
    if Pai0<=0.5
        P(i)=0;
    else
        P(i)=1;
    end
end
%------------------------------------------------
%% 显示结果
disp(['回归系数：' num2str(b')]);
disp(['评价结果：' num2str(P)]);

        