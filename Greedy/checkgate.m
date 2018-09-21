%% 检查登机口状态
% 输入数据格式：
%       time = 0:5:1440
%       Flight:<'PK062' 43119 895 'GK0523' 'D' 1525 43120 980 'GN0256' 'D' '73E' '转场情况' '登机口位置'>
%       Gate:<'T1' 'I' 'I' 'N' '占用情况' '占用次数' '占用时间' '飞机名称'>
function [Flight,Gate] = checkgate(Gate,time,Flight)
for g = 1:size(Gate,1)
    % 检查已占用登机口状态
    if (Gate{g,5}==1)
        % 当该登机口强制占用时间到时，开始记录空闲时间
        if (time == Gate{g,7}+45)
            Gate{g,5}=0;
            Gate{g,8}="";
        end
    else if (Gate{g,5}==0)
            Gate{g,9} = Gate{g,9}+5;
        end
    end
end

%{
%% 分配临时停机场中的飞机
for i = 1:size(Flight,1)
    if(Flight{i,13}=="temp"&&Flight{i,12}==0)
        [Flight(i,:),Gate]=assign(Flight(i,:),Gate);
    end
end
%}
