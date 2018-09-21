close all;
clear all;
clc;

%% ����׼��
%{
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
load 'Flight.mat';
load 'Gate.mat';
load 'Ticket_Final.mat'
%load 'Ticket.mat';
Flight_origin = Flight;
Gate_origin = Gate;
Ticket = Ticket_Final;
%Ticket_origin = Ticket;
[Flight,Gate] = DataPrepare(Flight_origin,Gate_origin);
[m,n]=size(Flight);
[p,q]=size(Gate);

%% ��ṹ,�����趨=================================================
% ��Ⱥ��Ⱦɫ�����
% ����������
Maxgen = 500; 
% ��Ⱥ��С
Y = 30;
% ��������
croPos = 0.7;
% ��������
mutPos = 0.1;
% Ȩ��
% w1 = 0.7;
% w2 = 0.3;
% ��Ŀ��or��Ŀ��
% goal = 0;
chroms = cell(1,Y);
%==========================================================================

%% ��ʱ��ʼ 
tic;
% ��ʼ����������ʼ����/��Ⱥ
for i = 1:Y
    structchroms.FlightSeNum = Flight(1:m,1)';
    structchroms.Gate = zeros(1,m);
    structchroms.unappropriated = zeros(1,m);
    structchroms.fitness1 = 0;
    structchroms.fitness2 = 0;
    structchroms.fitness3 = 0;
    structchroms.fitness = 0;
    chroms{1,i} = structchroms;
end

disp('����ǻ���');
% �ǻ��ڷ���!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
chroms = position(chroms, 'first', Flight, Gate);

%chroms{1,1}.Gate
disp('��Ӧ�ȼ���')
chroms = fitness2(chroms, Gate, Flight,Ticket);
%chroms{1,1}.Gate

% ��Ӧ��ֵ����!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
disp('��Ӧ������')
chroms = sortByFitness(chroms);

% ÿ����Ӣ����
chromBest = chroms{1,1};
% ��ʷ��¼
trace = zeros(1, Maxgen);
disp('������ʼ');
% ������ʼ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
k=1;
while(k<=Maxgen)
    STR = sprintf('%s%d','��������',k);
    disp(STR);
    
    % ѡ��
    chroms = selection(chroms);
    % ����
    chroms = crossover(chroms, croPos);
    % ����
    chroms = mutation(chroms, Gate, mutPos);
    % ����fitness
    chroms = position(chroms, 'else', Flight, Gate);
    chroms = fitness2(chroms, Gate, Flight, Ticket);
    % ��Ӧ��ֵ����
    chroms = sortByFitness(chroms,chromBest);
    % ͳ�ƣ�ȥ����Ӣ
    chromBest = chroms{1,1};
    trace(1,k) = chroms{1,1}.fitness;
    %trace(2,k) = chroms{1,1}.fitness2;
    %trace(3,k) = chroms{1,1}.fitness3;
    k=k+1;
end
% ��������!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% ��ʱ����
toc;

%% ������
% ��ʽ��1���Ÿ����У�2�������кţ�3�ǻ��ںţ�4��Ӧ��ֵ1��5��Ӧ��ֵ2��6��Ӧ��
disp('�������к�');
chroms{1,1}.FlightSeNum
disp('�ǻ��ں�');
Gate_output = chroms{1,1}.Gate';
%{
switch(goal)
    case 1
        disp('��Ŀ�꣺�ȴ�ʱ��');
        chroms{1,1}.fitness
        % ��������ͼĿ�꺯��1
        figure(1)
        plot(trace(1,:))
        hold on, grid;
        xlabel('��������');
        ylabel('���Ž�仯');
        title('��Ŀ�꣺�ȴ�ʱ��')
        
    case 2
        disp('��Ŀ�꣺��������ʱ��')
        chroms{1,1}.fitness2
        % ��������ͼĿ�꺯��2
        figure(2)
        plot(trace(2,:))
        hold on,grid;
        xlabel('��������');
        ylabel('���Ž�仯');
        title('��Ŀ�꣺����ʱ��')
end
%}

        


