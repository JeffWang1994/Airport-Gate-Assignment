%% ���ݴ���
% ���룺FRecord�ɻ�ת����¼�ţ�ADate�������ڣ�ATime����ʱ�䣻AFlight���ﺽ��ţ�AType�������ͣ�
%           FType�ɻ��ͺţ�LDate�������ڣ�LTime����ʱ�䣻LFight��������ţ�LType��������
%           Gate�ǻ��ڣ�GType�������ͣ�AGate�������ͣ�LGate��������
% �����AD����ʱ�䣻AT�������ͣ�LD����ʱ�䣬LT�������ͣ�WTת��ʱ�䣻FT�ɻ��ͺţ�
%           Gate�ǻ��ڣ�GT�������ͣ�AG�������ͣ�LG�������͡�
%% ���ݶ�ȡ
%FRecord = xlsread('InputData.xlsx','A2:A754');


%% ��ȡ����Ҫ�ĺ���
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

%% ��ȡ����Ҫ�ĵǻ���
Gate = [];
for i = 1:size(Gate_Num,1)
    Gate = [Gate; char(strcat(Gate_Num(i))),char(strcat(AGate(i))),char(strcat(LGate(i))),char(strcat(GType(i))),'0'];
end

