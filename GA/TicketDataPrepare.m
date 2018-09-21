
%% 换乘等待时间计算
%{
数据格式：
    Flight为存储航班信息的cells，其结构为：        Gate为存储登机口信息的cells，其结构为：       Ticket为存储用户信息的cells，其结构为：
        1.航班序列号(修改为1-m数字)                   1.登机口型号!!!                            1.旅客记录号
        2.到达日期                                   2.登机口号!!!                              2.乘客数
        3.到达时间!!!                                3.到达类型!!!                              3.到达航班号
        4.到达航班号                                 4.出发类型!!!                              4.到达日期
        5.到达类型!!!                                5.飞机大小!!!                              5.出发航班号
        6.转场时间!!!                                6.空闲开始时间                             6.出发日期
        7.出发日期                                                                              
        8.出发时间!!!                                                                           
        9.出发航班号
        10.出发类型!!!
        11.飞机大小!!!
%}
clear all;
clc;

load 'Flight.mat';
load 'Ticket_origin.mat';
Ticket = Ticket_origin;

%% Flight_All数据预处理
Flight = Flight;
for i = 1:size(Flight,1)
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

for k = 1:size(Flight,1)
    if(Flight{k,2}==19)
        Flight{k,3} = Flight{k,3};
    elseif (Flight{k,2}==20)
        Flight{k,3} = Flight{k,3}+1440;
    end
end
for k = 1:size(Flight,1)
    if (Flight{k,7}==20)
        Flight{k,8} = Flight{k,8}+1440;
    elseif (Flight{k,7}==21)
        Flight{k,8} = Flight{k,8}+2880;
    end
end
Flight = Flight(1:242,:);

%% Ticket数据日期修改
for i = 1:size(Ticket,1)
    if(Ticket{i,4}==43119)
        Ticket{i,4}=19;
    elseif (Ticket{i,4}==43120)
        Ticket{i,4}=20;
    end
    if(Ticket{i,6}==43120)
        Ticket{i,6}=20;
    elseif (Ticket{i,6}==43121)
        Ticket{i,6}=21;
    end
end

Ticket_Arrive = cell(size(Ticket,1),3);
Ticket_Leave = cell(size(Ticket,1),3);
Ticket_Time = zeros(size(Ticket,1),1);

for j = 1:size(Ticket,1)
    for i = 1:size(Flight,1)
        if (string(Ticket{j,3})==string(Flight{i,4}))
            Ticket_Arrive{j,1}=i;   % 到达航班序列号
            Ticket_Arrive{j,2}=Flight{i,5};     % 到达类型
            Ticket_Arrive{j,3}=Flight{i,3};     % 到达时间
        end
        if (string(Ticket{j,5})==string(Flight{i,9}))
            Ticket_Leave{j,1}=i;    % 出发航班序列号
            Ticket_Leave{j,2}=Flight{i,10};     % 出发类型
            Ticket_Leave{j,3}=Flight{i,8};      % 到达时间
        end
    end
end

for i = 1:size(Ticket,1)
    if (isempty(Ticket_Arrive{i,3}))||(isempty(Ticket_Leave{i,3}))
        Ticket_Time(i)=0;
    else
    Ticket_Time(i) = Ticket_Leave{i,3}-Ticket_Arrive{i,3};
    end
end

%% 整理
%{
    Ticket为存储用户信息的cells，其结构为：
        1.旅客记录号
        2.乘客数
        3.到达航班号-->到达航班序列号
        4.到达日期
        5.到达时间
        6.到达类型
        7.出发航班号-->出发航班序列号
        8.出发日期
        9.出发时间
        10.出发类型
        11.航班间最短换乘时间
%}
Ticket_Final = cell(size(Ticket,1),11);
for i = 1:size(Ticket,1)
    if (~isempty(Ticket_Arrive{i,1}))||(~isempty(Ticket_Leave{i,1}))
    Ticket_Final{i,1} = Ticket{i,1};    % 旅客记录号
    Ticket_Final{i,2} = Ticket{i,2};    % 乘客数
    Ticket_Final{i,3} = Ticket_Arrive{i,1};     % 到达航班序列号
    Ticket_Final{i,4} = Ticket{i,4};    % 到达日期
    Ticket_Final{i,5} = Ticket_Arrive{i,3};     % 到达时间
    Ticket_Final{i,6} = Ticket_Arrive{i,2};     % 到达类型
    Ticket_Final{i,7} = Ticket_Leave{i,1};
    Ticket_Final{i,8} = Ticket{i,6};
    Ticket_Final{i,9} = Ticket_Leave{i,3};
    Ticket_Final{i,10} = Ticket_Leave{i,2};
    Ticket_Final{i,11} = Ticket_Time(i);
    else
        continue;
    end
end

i=1;
while i<=size(Ticket_Final,1)
     if (isempty(Ticket_Final{i,3}))||(isempty(Ticket_Final{i,7}))
        Ticket_Final(i,:)=[];
     end
     i = i+1;
end

Ticket = Ticket_Final;

j =1;
while j <=1000
    if(Ticket{j,11}==0)
        Ticket(j,:)=[];
    end
    j=j+1;
end



        