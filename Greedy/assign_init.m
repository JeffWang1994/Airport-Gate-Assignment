%% 分配19号就到了的飞机
% 输入数据格式：
%       Flight:<'PK062' 43119 895 'GK0523' 'D' 1525 43120 980 'GN0256' 'D' '73E' '转场情况' '登机口位置'>
%       Gate:<'T1' 'I' 'I' 'N' '占用情况' '占用次数' '占用时间' '空闲时间'>
%输出数据：
%       主要更改Flight的'转场情况'，'登机口位置'，Gate的'占用情况', '占用次数', '占用时间', '空闲时间'
function [Flight,Gate] = assign_init(Flight,Gate)

Assign_Done = 0;

%开始检查
for i  = 1:size(Gate,1)
    % 首先检查该端口是否空闲
    if (Gate{i,5}==0)
        % 到达类型和出发类型的检查
        % 由于其中有D, I登机口的存在，所以首先分配单属性登机口，再分配双属性登机口
        Arrive_Check = (string(Flight{1,5})==string(Gate{i,2}))||(string(Gate{i,2})=="D, I");
        Leave_Check = (string(Flight{1,10})==string(Gate{i,3}))||(string(Gate{i,3})=="D, I");
        Arrive_Check2 = (string(Gate{i,2})=="D, I");
        Leave_Check2 = (string(Gate{i,3})=="D, I");
        
        % 根据飞机型号与飞机宽窄的表，进行判断飞机大小
        if (string(Flight{1,11})=="332")||(string(Flight{1,11})=="333")||(string(Flight{1,11})=="33E")||(string(Flight{1,11})=="33H")||(string(Flight{1,11})=="33L")||(string(Flight{1,11})=="773")
            Plane_Type = "W";
        else
            Plane_Type = "N";
        end
        
        % 检查飞机大小和登机口大小是否匹配
        Type_Check = (Plane_Type==string(Gate{i,4}));
        
        %%开始分配
        % 共考虑三个属性的匹配：到达类型，出发类型，飞机大小
        % 优先考虑到达类型，出发类型完全匹配且为单属性的登机口
        if (Arrive_Check&&Leave_Check&&Type_Check)
            Gate{i,5} = 1;
            Gate{i,6} = Gate{i,6}+1;
            Gate{i,7} = Flight{1,8};
            Gate{i,8} = Flight{1,1};
            Flight{1,12} = 1;
            Flight{1,13} = string(Gate{i,1});
            Assign_Done = 1;    % 完成分配
            break
        end
    end
end

if Assign_Done == 0
    
%% 对单属性登机口无法装下的飞机，进行单边双属性登机口分配
for  j = 1:size(Gate,1)
    if (Gate{i,5}==0)
        Arrive_Check = (string(Flight{1,5})==string(Gate{i,2}))||(string(Gate{i,2})=="D, I");
        Leave_Check = (string(Flight{1,10})==string(Gate{i,3}))||(string(Gate{i,3})=="D, I");
        Arrive_Check2 = (string(Gate{i,2})=="D, I");
        Leave_Check2 = (string(Gate{i,3})=="D, I");
        
        % 根据飞机型号与飞机宽窄的表，进行判断飞机大小
        if (string(Flight{1,11})=="332")||(string(Flight{1,11})=="333")||(string(Flight{1,11})=="33E")||(string(Flight{1,11})=="33H")||(string(Flight{1,11})=="33L")||(string(Flight{1,11})=="773")
            Plane_Type = "W";
        else
            Plane_Type = "N";
        end
        % 检查飞机大小和登机口大小是否匹配
        Type_Check = (Plane_Type==string(Gate{i,4}));
        
        %%开始分配
        % 共考虑三个属性的匹配：到达类型，出发类型，飞机大小
        % 优先考虑到达类型，出发类型完全匹配且为单属性的登机口
        if (Arrive_Check2&&Leave_Check&&Type_Check)||(Arrive_Check&&Leave_Check2&&Type_Check)
            Gate{i,5} = 1;
            Gate{i,6} = Gate{i,6}+1;
            Gate{i,7} = Flight{1,8};
            Flight{1,12} = 1;
            Flight{1,13} = string(Gate{i,1});
            Assign_Done = 1;    % 完成分配
            break
        end
    end
end
end

if Assign_Done == 0   
%% 最后进行双边双属性登机口分配
for k = 1:size(Gate,1)
    if (Gate{i,5}==0)
        Arrive_Check = (string(Flight{1,5})==string(Gate{i,2}))||(string(Gate{i,2})=="D, I");
        Leave_Check = (string(Flight{1,10})==string(Gate{i,3}))||(string(Gate{i,3})=="D, I");
        Arrive_Check2 = (string(Gate{i,2})=="D, I");
        Leave_Check2 = (string(Gate{i,3})=="D, I");
        
        % 根据飞机型号与飞机宽窄的表，进行判断飞机大小
        if (string(Flight{1,11})=="332")||(string(Flight{1,11})=="333")||(string(Flight{1,11})=="33E")||(string(Flight{1,11})=="33H")||(string(Flight{1,11})=="33L")||(string(Flight{1,11})=="773")
            Plane_Type = "W";
        else
            Plane_Type = "N";
        end
        % 检查飞机大小和登机口大小是否匹配
        Type_Check = (Plane_Type==string(Gate{i,4}));
        
        %%开始分配
        % 共考虑三个属性的匹配：到达类型，出发类型，飞机大小
        % 优先考虑到达类型，出发类型完全匹配且为单属性的登机口
        if (Arrive_Check2&&Leave_Check2&&Type_Check)
            Gate{i,5} = 1;
            Gate{i,6} = Gate{i,6}+1;
            Gate{i,7} = Flight{1,8};
            Flight{1,12} = 1;
            Flight{1,13} = string(Gate{i,1});
            Assign_Done =1; % 完成分配
            break
        end
    end
end
end


%% 最后将均不满足上述情况的飞机，放入临时停机场
if Assign_Done == 0 
    Flight{1,12}=0;
    Flight{1,13}="temp";
end


    
    