
%% ���˵ȴ�ʱ�����
%{
���ݸ�ʽ��
    FlightΪ�洢������Ϣ��cells����ṹΪ��        GateΪ�洢�ǻ�����Ϣ��cells����ṹΪ��       TicketΪ�洢�û���Ϣ��cells����ṹΪ��
        1.�������к�(�޸�Ϊ1-m����)                   1.�ǻ����ͺ�!!!                            1.�ÿͼ�¼��
        2.��������                                   2.�ǻ��ں�!!!                              2.�˿���
        3.����ʱ��!!!                                3.��������!!!                              3.���ﺽ���
        4.���ﺽ���                                 4.��������!!!                              4.��������
        5.��������!!!                                5.�ɻ���С!!!                              5.���������
        6.ת��ʱ��!!!                                6.���п�ʼʱ��                             6.��������
        7.��������                                                                              
        8.����ʱ��!!!                                                                           
        9.���������
        10.��������!!!
        11.�ɻ���С!!!
%}
clear all;
clc;

load 'Flight.mat';
load 'Ticket_origin.mat';
Ticket = Ticket_origin;

%% Flight_All����Ԥ����
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

%% Ticket���������޸�
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
            Ticket_Arrive{j,1}=i;   % ���ﺽ�����к�
            Ticket_Arrive{j,2}=Flight{i,5};     % ��������
            Ticket_Arrive{j,3}=Flight{i,3};     % ����ʱ��
        end
        if (string(Ticket{j,5})==string(Flight{i,9}))
            Ticket_Leave{j,1}=i;    % �����������к�
            Ticket_Leave{j,2}=Flight{i,10};     % ��������
            Ticket_Leave{j,3}=Flight{i,8};      % ����ʱ��
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

%% ����
%{
    TicketΪ�洢�û���Ϣ��cells����ṹΪ��
        1.�ÿͼ�¼��
        2.�˿���
        3.���ﺽ���-->���ﺽ�����к�
        4.��������
        5.����ʱ��
        6.��������
        7.���������-->�����������к�
        8.��������
        9.����ʱ��
        10.��������
        11.�������̻���ʱ��
%}
Ticket_Final = cell(size(Ticket,1),11);
for i = 1:size(Ticket,1)
    if (~isempty(Ticket_Arrive{i,1}))||(~isempty(Ticket_Leave{i,1}))
    Ticket_Final{i,1} = Ticket{i,1};    % �ÿͼ�¼��
    Ticket_Final{i,2} = Ticket{i,2};    % �˿���
    Ticket_Final{i,3} = Ticket_Arrive{i,1};     % ���ﺽ�����к�
    Ticket_Final{i,4} = Ticket{i,4};    % ��������
    Ticket_Final{i,5} = Ticket_Arrive{i,3};     % ����ʱ��
    Ticket_Final{i,6} = Ticket_Arrive{i,2};     % ��������
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



        