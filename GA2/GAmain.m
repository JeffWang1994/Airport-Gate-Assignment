close all;
clear all;
clc;

%% 数据准备
%{
数据格式：
    chroms为一个存储struct的cells。struct的结构为：
        1.FlightSeNum       1*303
        2.Gate              1*303
        3.unappropriated    1*303
        4.fitness           1*1
    Flight为存储航班信息的cells，其结构为：
        1.航班序列号(修改为1-m数字)
        2.到达日期
        3.到达时间!!!
        4.到达航班号
        5.到达类型!!!
        6.转场时间!!!
        7.出发日期
        8.出发时间!!!
        9.出发航班号
        10.出发类型!!!
        11.飞机大小!!!
    Gate为存储登机口信息的cells，其结构为：
        1.登机口型号!!!
        2.登机口号!!!
        3.到达类型!!!
        4.出发类型!!!
        5.飞机大小!!!
        6.空闲开始时间(需要增添)
    Ticket为存储用户信息的cells，其结构为：
        1.旅客记录号
        2.乘客数
        3.到达航班号
        4.到达日期
        5.出发航班号
        6.出发日期
%}
load 'Flight.mat';
load 'Gate.mat';
load 'Ticket_Final.mat'
%load 'Ticket.mat';
Flight_origin = Flight;
Gate_origin = Gate;
Ticket = Ticket_Final;
%Ticket_origin = Ticket;
[Flight,Gate] = DataPrepare(Flight_origin,Gate_origin);
[m,n]=size(Flight);
[p,q]=size(Gate);

%% 解结构,参数设定=================================================
% 种群，染色体组成
% 最大迭代次数
Maxgen = 500; 
% 种群大小
Y = 30;
% 交叉算子
croPos = 0.7;
% 变异算子
mutPos = 0.1;
% 权重
% w1 = 0.7;
% w2 = 0.3;
% 单目标or多目标
% goal = 0;
chroms = cell(1,Y);
%==========================================================================

%% 计时开始 
tic;
% 初始化，构建初始方案/种群
for i = 1:Y
    structchroms.FlightSeNum = Flight(1:m,1)';
    structchroms.Gate = zeros(1,m);
    structchroms.unappropriated = zeros(1,m);
    structchroms.fitness1 = 0;
    structchroms.fitness2 = 0;
    structchroms.fitness3 = 0;
    structchroms.fitness = 0;
    chroms{1,i} = structchroms;
end

disp('分配登机口');
% 登机口分配!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
chroms = position(chroms, 'first', Flight, Gate);

%chroms{1,1}.Gate
disp('适应度计算')
chroms = fitness2(chroms, Gate, Flight,Ticket);
%chroms{1,1}.Gate

% 适应度值排序!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
disp('适应度排序')
chroms = sortByFitness(chroms);

% 每代精英策略
chromBest = chroms{1,1};
% 历史纪录
trace = zeros(1, Maxgen);
disp('迭代开始');
% 迭代开始!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
k=1;
while(k<=Maxgen)
    STR = sprintf('%s%d','进化代数',k);
    disp(STR);
    
    % 选择
    chroms = selection(chroms);
    % 交叉
    chroms = crossover(chroms, croPos);
    % 变异
    chroms = mutation(chroms, Gate, mutPos);
    % 计算fitness
    chroms = position(chroms, 'else', Flight, Gate);
    chroms = fitness2(chroms, Gate, Flight, Ticket);
    % 适应度值排序
    chroms = sortByFitness(chroms,chromBest);
    % 统计，去除精英
    chromBest = chroms{1,1};
    trace(1,k) = chroms{1,1}.fitness;
    %trace(2,k) = chroms{1,1}.fitness2;
    %trace(3,k) = chroms{1,1}.fitness3;
    k=k+1;
end
% 迭代结束!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% 计时结束
toc;

%% 输出结果
% 格式：1最优个体行：2航班序列号：3登机口号：4适应度值1：5适应度值2：6适应度
disp('航班序列号');
chroms{1,1}.FlightSeNum
disp('登机口号');
Gate_output = chroms{1,1}.Gate';
%{
switch(goal)
    case 1
        disp('单目标：等待时间');
        chroms{1,1}.fitness
        % 画出迭代图目标函数1
        figure(1)
        plot(trace(1,:))
        hold on, grid;
        xlabel('进化代数');
        ylabel('最优解变化');
        title('单目标：等待时间')
        
    case 2
        disp('单目标：换乘流程时间')
        chroms{1,1}.fitness2
        % 画出迭代图目标函数2
        figure(2)
        plot(trace(2,:))
        hold on,grid;
        xlabel('进化代数');
        ylabel('最优解变化');
        title('单目标：换乘时间')
end
%}

        


