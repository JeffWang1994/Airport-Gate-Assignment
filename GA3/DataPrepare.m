function [Flight,Gate] = DataPrepare(Flight_origin,Gate_origin)
%% ����Ԥ����
%{
���ݸ�ʽ��
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
        1.�ǻ��ںţ��޸�Ϊ1-n���֣�����һ��Ϊ�ǻ�������'T'��'S'��
        2.��������!!!
        3.��������!!!
        4.�ɻ���С!!!
        5.���п�ʼʱ��(��Ҫ����)
%}

%% Flight����Ԥ����
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

%% Gate����Ԥ����
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
    