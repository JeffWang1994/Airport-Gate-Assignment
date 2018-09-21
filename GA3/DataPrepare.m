function [Flight,Gate] = DataPrepare(Flight_origin,Gate_origin)
%% 数据预处理
%{
数据格式：
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
        1.登机口号（修改为1-n数字，增添一行为登机口类型'T'和'S'）
        2.到达类型!!!
        3.出发类型!!!
        4.飞机大小!!!
        5.空闲开始时间(需要增添)
%}

%% Flight数据预处理
Flight = Flight_origin;
for i = 1:size(Flight_origin,1)
    Flight(i,1) = {i};
    if(Flight{i,2}==43119)
        Flight{i,2} = 19;
    elseif(Flight{i,2}==43120)
        Flight{i,2} = 20;
    end
    if(Flight{i,7}==43120)
        Flight{i,7} = 20;
    elseif(Flight{i,7}==43121)
        Flight{i,7} = 21;
    end
    if((string(Flight{i,11})=="332")||(string(Flight{i,11})=="333")||(string(Flight{i,11})=="33E")||(string(Flight{i,11})=="33H")||(string(Flight{i,11})=="33L")||(string(Flight{i,11})=="773"))
        Flight{i,11} = 'W';
    else
        Flight{i,11} = 'N';
    end
end

for k = 1:size(Flight_origin,1)
    if(Flight{k,2}==19)
        Flight{k,3} = Flight{k,3};
    elseif (Flight{k,2}==20)
        Flight{k,3} = Flight{k,3}+1440;
    end
end
for k = 1:size(Flight_origin,1)
    if (Flight{k,7}==20)
        Flight{k,8} = Flight{k,8}+1440;
    elseif (Flight{k,7}==21)
        Flight{k,8} = Flight{k,8}+2880;
    end
end

Flight = Flight(1:242,:);

%% Gate数据预处理
Gate = Gate_origin;
Gate_output = cell(size(Gate,1),6);
T=1;
S=1;
for j = 1:size(Gate_origin,1)
    if (Gate{j,1}(1,1)=='T')
        Gate_output{j,1} = 'T';
        Gate_output{j,2} = T;
        Gate_output{j,3} = Gate{j,2};
        Gate_output{j,4} = Gate{j,3};
        Gate_output{j,5} = Gate{j,4};
        Gate_output{j,6} = 0;
        T = T+1;
    elseif (Gate{j,1}(1,1)=='S')
        Gate_output{j,1} = 'S';
        Gate_output{j,2} = S;
        Gate_output{j,3} = Gate{j,2};
        Gate_output{j,4} = Gate{j,3};
        Gate_output{j,5} = Gate{j,4};
        Gate_output{j,6} = 0;
        S = S+1;
    end
end
Gate = Gate_output;
    