%% �������ݣ��������ʶλ
% ���ݸ�ʽΪ��
%       Flight:<'PK062' 43119 895 'GK0523' 'D' 1525 43120 980 'GN0256' 'D' '73E' 'ת�����' '�ǻ���λ��'>
%       Gate:<'T1' 'I' 'I' 'N' 'ռ�����' 'ռ�ô���' 'ռ��ʱ��' '����ʱ��'>
clear all
clc

load 'Flight.mat';
load 'Gate.mat';

Gate_origin = Gate;
Gate = [];
for i = 1:size(Gate_origin,1)
    Gate = [Gate; Gate_origin(i,:),{0},{0},{0},{""},{0}];%��һ��0Ϊ�Ƿ�ռ�ñ�ʶ���ڶ���0Ϊռ�ô�����������0Ϊ����ʱ��
end

Flight_origin = Flight;
Flight = [];
for i = 1:size(Flight_origin,1)
    Flight = [Flight; Flight_origin(i,:),{0},{""}];
end

%% ��ʼ�������ǻ��ڷ��䣬��Ҫ����19�ž����˵ķɻ�
for i = 1:size(Flight,1)
    if (Flight{i,2}==43119)
        [Flight(i,:), Gate] = assign_init(Flight(i,:),Gate);
    end
end

% �ǻ��ڷ���
% 1.���ÿһ���ǻ��ڣ�ÿ5���ӽ��м��һ�Σ���ռ�������
% 2.��һ�ܷɻ�Ҫ����ʱ�����Ȳ����ѿ��ŵĵǻ��ڣ��鿴�Ƿ���δռ��������ĵǻ���
% 3.���ѿ��ŵǻ��ڶ���ռ��ʱ�������¿��ǻ���
for time = 0:5:1440
    [Flight,Gate] = checkgate(Gate,time,Flight);
    for i = 1:size(Flight,1)
        if(time == Flight{i,3}&&Flight{i,12}==0)
            [Flight(i,:),Gate]=assign(Flight(i,:),Gate);
        end
    end
end

    
