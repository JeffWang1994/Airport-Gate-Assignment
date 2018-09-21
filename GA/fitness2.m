function chroms = fitness2(chroms, Gate, Flight,Ticket)
%% �ú������ڼ���chroms����Ӧ�ȡ�
%{
% ��Ӧ�ȷ�Ϊ�����֣��ǻ���������
% ת���ʼ��㣺����unappropriated����⡣ת����=sum(unappropriated)/m
% �ǻ��������ʼ��㣺
���ݸ�ʽ��
    chromsΪһ���洢struct��cells��struct�ĽṹΪ��
        1.FlightSeNum       1*303
        2.Gate              1*303
        3.unappropriated    1*303
        4.fitness           1*1
    FlightΪ�洢������Ϣ��cells����ṹΪ��
        1.�������к�(�޸�Ϊ1-m����)
        2.��������
        3.����ʱ��!!!
        4.���ﺽ���
        5.��������!!!
        6.ת��ʱ��!!!
        7.��������
        8.����ʱ��!!!
        9.���������
        10.��������!!!
        11.�ɻ���С!!!
    GateΪ�洢�ǻ�����Ϣ��cells����ṹΪ��
        1.�ǻ����ͺ�!!!
        2.�ǻ��ں�!!!
        3.��������!!!
        4.��������!!!
        5.�ɻ���С!!!
        6.���п�ʼʱ��(��Ҫ����)
    TicketΪ�洢�û���Ϣ��cells����ṹΪ��
        1.�ÿͼ�¼��
        2.�˿���
        3.���ﺽ���
        4.��������
        5.���������
        6.��������
%}
[~,n] = size(chroms);
[~,m] = size(chroms{1,1}.FlightSeNum);

%% �ǻ��������ʼ���
chromsIndex = 1;    % ���ÿ��Ⱦɫ����м���
while chromsIndex<=n
    % ͳ�Ƶ�chromsIndex��ÿ�ܷɻ����ڵǻ��ںţ�Ȼ����ݸ÷ɻ��ĳ���ʱ��-����ʱ��
    % ���õǻ��ڵ�ռ��ʱ�䡣�Ӷ����õǻ��ڵ�������
    % �ǻ���������Խ�ߣ��ǻ�������Ҫ���ŵ������ͻ�Խ�٣��ɻ���ͣ���ɹ��ʾ�Խ�ߡ�
    % �޸�Ϊ19�ŵ���ʱ��
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
    % ���ƽ���ǻ���������
    chroms{1,chromsIndex}.fitness =AverageProbability; 
    chromsIndex = chromsIndex+1;
end

%% ��������ʱ��Ŀ�꺯��
for chromsIndex = 1:n
    for i = 1:size(Ticket,1)
        if (Ticket{i,6}=='D')&&(Ticket{i,10}=='D')...
                &&(chroms{1,chromsIndex}.Gate(Ticket{i,3})<=28)...
                &&(chroms{1,chromsIndex}.Gate(Ticket{i,7}))



        
        
    
        
    
    
    
        