%% ���ǻ���״̬
% �������ݸ�ʽ��
%       time = 0:5:1440
%       Flight:<'PK062' 43119 895 'GK0523' 'D' 1525 43120 980 'GN0256' 'D' '73E' 'ת�����' '�ǻ���λ��'>
%       Gate:<'T1' 'I' 'I' 'N' 'ռ�����' 'ռ�ô���' 'ռ��ʱ��' '�ɻ�����'>
function [Flight,Gate] = checkgate(Gate,time,Flight)
for g = 1:size(Gate,1)
    % �����ռ�õǻ���״̬
    if (Gate{g,5}==1)
        % ���õǻ���ǿ��ռ��ʱ�䵽ʱ����ʼ��¼����ʱ��
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
%% ������ʱͣ�����еķɻ�
for i = 1:size(Flight,1)
    if(Flight{i,13}=="temp"&&Flight{i,12}==0)
        [Flight(i,:),Gate]=assign(Flight(i,:),Gate);
    end
end
%}
