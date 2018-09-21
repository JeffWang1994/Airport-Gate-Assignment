%% 数据处理
% 输入：FRecord飞机转场记录号；ADate到达日期；ATime到达时间；AFlight到达航班号；AType到达类型；
%           FType飞机型号；LDate出发日期；LTime出发时间；LFight出发航班号；LType出发类型
%           Gate登机口；GType机体类型；AGate到达类型；LGate出发类型
% 输出：AD到达时间；AT到达类型；LD出发时间，LT出发类型；WT转场时间；FT飞机型号；
%           Gate登机口；GT机体类型；AG到达类型；LG出发类型。
%% 数据读取
%FRecord = xlsread('InputData.xlsx','A2:A754');


%% 提取所需要的航班
Flight = [];
for i = 1:size(ADate,1)
    if (ADate(i) == 43120)||(LDate(i) == 43120)
        if (ADate(i) == LDate(i))
            WaitTime = LTime_cal(i) - ATime_cal(i);
            %{
            if (FType(i)=='332')||(FType(i)=='333')||(FType(i)=='33E')||(FType(i)=='33H')||(FType(i)=='33L')||(FType(i)=='773')
                Type = 'W';
            else
                Type = 'N';
            end
            %}
            Flight = [Flight; FRecord(i) ADate(i) ATime(i) AFlight(i) AType(i) WaitTime LDate(i) LTime(i) LFight(i) LType(i) FType(i)];
        else if (LDate(i) == (ADate(i)+1))
                WaitTime = LTime_cal(i)+1440-ATime_cal(i);
                Flight = [Flight; FRecord(i) ADate(i) ATime(i) AFlight(i) AType(i) WaitTime LDate(i) LTime(i) LFight(i) LType(i) FType(i)];
            end
        end
    end
end

%% 提取所需要的登机口
Gate = [];
for i = 1:size(Gate_Num,1)
    Gate = [Gate; char(strcat(Gate_Num(i))),char(strcat(AGate(i))),char(strcat(LGate(i))),char(strcat(GType(i))),'0'];
end

