%% 多目标优化算法 NSGA-II 带精英策略的快速非支配排序遗传算法
% 此算法由Kalyanmoy Deb提出，是应用最为广泛且最为成功的一种
% MATLAB自带函数gamultiobj，该函数是基于NSGA-II改进的一种多目标优化算法
% 程序目录：
% 适应值函数m文件：gamultiobj_fitness.m
% 主程序m文件：gamultiobj_main.m

%% gamultiobj_main.m
clear
clc
%适应度函数句柄
fitnessfcn = @gamultiobj_fitness;
% 变量个数
nvars = 2;
% 上限，下限
lb = [-5,-5];
ub = [5,5];
% 线性不等式约束，线性等式约束
A = [];b = [];
Aeq = [];beq = [];
% 设置：最优个体系数paretoFraction为0.3；种群大小populationsize为100；最大进化代数generation为200；
% 设置：停止代数stallGenLimit为200；适应度函数偏差TolFun为1e-100；函数gaplotpareto：绘制Pareto前端
options = gaoptimset('paretoFraction',0.3,'populationsize',100,'generations',2000,'stallGenLimit',2000,'TolFun',1e-100,'PlotFcns',@gaplotpareto);
[x,fval] = gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,options)