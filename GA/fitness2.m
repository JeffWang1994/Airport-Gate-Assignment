function chroms = fitness2(chroms, Gate, Flight,Ticket)
%% 该函数用于计算chroms的适应度。
%{
% 适应度分为三部分：登机口利用率
% 转场率计算：根据unappropriated来求解。转场率=sum(unappropriated)/m
% 登机口利用率计算：
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
[~,n] = size(chroms);
[~,m] = size(chroms{1,1}.FlightSeNum);

%% 登机口利用率计算
chromsIndex = 1;    % 针对每个染色体进行计算
while chromsIndex<=n
    % 统计第chromsIndex中每架飞机所在登机口号，然后根据该飞机的出发时间-到达时间
    % 求解该登机口的占用时间。从而求解该登机口的利用率
    % 登机口利用率越高，登机口所需要开放的数量就会越少，飞机的停靠成功率就越高。
    % 修改为19号当天时间
    for i = 1:size(Flight,1)
        if (Flight{i,2}==19)
            Flight{i,3} = 1440;
        elseif (Flight{i,2}==20)
            Flight{i,3} = Flight{i,3};
        end
        if (Flight{i,7}==20)
            Flight{i,8} = Flight{i,8};
        elseif (Flight{i,7}==21)
            Flight{i,8} = 2880;
        end
    end
    GateUSEDTime_re = zeros(size(Gate,1),1);
    for j = 1:size(Flight,1)
        gate = chroms{1,chromsIndex}.Gate(j);
        if(gate~=0)
            GateUSEDTime_re(gate) = GateUSEDTime_re(gate)+(Flight{j,8}-Flight{j,3});
        end
    end
    GateNum = 0;
    for k = 1:size(GateUSEDTime_re,1)
        if(GateUSEDTime_re(k)~=0)
            GateNum = GateNum+1;
        end
    end
    if (sum(GateUSEDTime_re)~=0)
        GateUSEDProbability = GateUSEDTime_re/1440;
        AverageProbability = sum(GateUSEDProbability)/GateNum;
    else
        AverageProbability = 0;
    end
    % 求解平均登机口利用率
    chroms{1,chromsIndex}.fitness =AverageProbability; 
    chromsIndex = chromsIndex+1;
end

%% 换乘所用时间目标函数
for chromsIndex = 1:n
    for i = 1:size(Ticket,1)
        if (Ticket{i,6}=='D')&&(Ticket{i,10}=='D')...
                &&(chroms{1,chromsIndex}.Gate(Ticket{i,3})<=28)...
                &&(chroms{1,chromsIndex}.Gate(Ticket{i,7}))



        
        
    
        
    
    
    
        