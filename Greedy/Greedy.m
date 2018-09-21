%% 加载数据，并补充标识位
% 数据格式为：
%       Flight:<'PK062' 43119 895 'GK0523' 'D' 1525 43120 980 'GN0256' 'D' '73E' '转场情况' '登机口位置'>
%       Gate:<'T1' 'I' 'I' 'N' '占用情况' '占用次数' '占用时间' '空闲时间'>
clear all
clc

load 'Flight.mat';
load 'Gate.mat';

Gate_origin = Gate;
Gate = [];
for i = 1:size(Gate_origin,1)
    Gate = [Gate; Gate_origin(i,:),{0},{0},{0},{""},{0}];%第一个0为是否占用标识，第二个0为占用次数，第三个0为闲置时间
end

Flight_origin = Flight;
Flight = [];
for i = 1:size(Flight_origin,1)
    Flight = [Flight; Flight_origin(i,:),{0},{""}];
end

%% 初始化机场登机口分配，主要分配19号就来了的飞机
for i = 1:size(Flight,1)
    if (Flight{i,2}==43119)
        [Flight(i,:), Gate] = assign_init(Flight(i,:),Gate);
    end
end

% 登机口分配
% 1.针对每一个登机口，每5分钟进行检查一次，看占用情况。
% 2.当一架飞机要进场时，优先查找已开放的登机口，查看是否有未占用且满足的登机口
% 3.当已开放登机口都被占用时，考虑新开登机口
for time = 0:5:1440
    [Flight,Gate] = checkgate(Gate,time,Flight);
    for i = 1:size(Flight,1)
        if(time == Flight{i,3}&&Flight{i,12}==0)
            [Flight(i,:),Gate]=assign(Flight(i,:),Gate);
        end
    end
end

    
