%% ����19�ž͵��˵ķɻ�
% �������ݸ�ʽ��
%       Flight:<'PK062' 43119 895 'GK0523' 'D' 1525 43120 980 'GN0256' 'D' '73E' 'ת�����' '�ǻ���λ��'>
%       Gate:<'T1' 'I' 'I' 'N' 'ռ�����' 'ռ�ô���' 'ռ��ʱ��' '����ʱ��'>
%������ݣ�
%       ��Ҫ����Flight��'ת�����'��'�ǻ���λ��'��Gate��'ռ�����', 'ռ�ô���', 'ռ��ʱ��', '����ʱ��'
function [Flight,Gate] = assign_init(Flight,Gate)

Assign_Done = 0;

%��ʼ���
for i  = 1:size(Gate,1)
    % ���ȼ��ö˿��Ƿ����
    if (Gate{i,5}==0)
        % �������ͺͳ������͵ļ��
        % ����������D, I�ǻ��ڵĴ��ڣ��������ȷ��䵥���Եǻ��ڣ��ٷ���˫���Եǻ���
        Arrive_Check = (string(Flight{1,5})==string(Gate{i,2}))||(string(Gate{i,2})=="D, I");
        Leave_Check = (string(Flight{1,10})==string(Gate{i,3}))||(string(Gate{i,3})=="D, I");
        Arrive_Check2 = (string(Gate{i,2})=="D, I");
        Leave_Check2 = (string(Gate{i,3})=="D, I");
        
        % ���ݷɻ��ͺ���ɻ���խ�ı������жϷɻ���С
        if (string(Flight{1,11})=="332")||(string(Flight{1,11})=="333")||(string(Flight{1,11})=="33E")||(string(Flight{1,11})=="33H")||(string(Flight{1,11})=="33L")||(string(Flight{1,11})=="773")
            Plane_Type = "W";
        else
            Plane_Type = "N";
        end
        
        % ���ɻ���С�͵ǻ��ڴ�С�Ƿ�ƥ��
        Type_Check = (Plane_Type==string(Gate{i,4}));
        
        %%��ʼ����
        % �������������Ե�ƥ�䣺�������ͣ��������ͣ��ɻ���С
        % ���ȿ��ǵ������ͣ�����������ȫƥ����Ϊ�����Եĵǻ���
        if (Arrive_Check&&Leave_Check&&Type_Check)
            Gate{i,5} = 1;
            Gate{i,6} = Gate{i,6}+1;
            Gate{i,7} = Flight{1,8};
            Gate{i,8} = Flight{1,1};
            Flight{1,12} = 1;
            Flight{1,13} = string(Gate{i,1});
            Assign_Done = 1;    % ��ɷ���
            break
        end
    end
end

if Assign_Done == 0
    
%% �Ե����Եǻ����޷�װ�µķɻ������е���˫���Եǻ��ڷ���
for  j = 1:size(Gate,1)
    if (Gate{i,5}==0)
        Arrive_Check = (string(Flight{1,5})==string(Gate{i,2}))||(string(Gate{i,2})=="D, I");
        Leave_Check = (string(Flight{1,10})==string(Gate{i,3}))||(string(Gate{i,3})=="D, I");
        Arrive_Check2 = (string(Gate{i,2})=="D, I");
        Leave_Check2 = (string(Gate{i,3})=="D, I");
        
        % ���ݷɻ��ͺ���ɻ���խ�ı������жϷɻ���С
        if (string(Flight{1,11})=="332")||(string(Flight{1,11})=="333")||(string(Flight{1,11})=="33E")||(string(Flight{1,11})=="33H")||(string(Flight{1,11})=="33L")||(string(Flight{1,11})=="773")
            Plane_Type = "W";
        else
            Plane_Type = "N";
        end
        % ���ɻ���С�͵ǻ��ڴ�С�Ƿ�ƥ��
        Type_Check = (Plane_Type==string(Gate{i,4}));
        
        %%��ʼ����
        % �������������Ե�ƥ�䣺�������ͣ��������ͣ��ɻ���С
        % ���ȿ��ǵ������ͣ�����������ȫƥ����Ϊ�����Եĵǻ���
        if (Arrive_Check2&&Leave_Check&&Type_Check)||(Arrive_Check&&Leave_Check2&&Type_Check)
            Gate{i,5} = 1;
            Gate{i,6} = Gate{i,6}+1;
            Gate{i,7} = Flight{1,8};
            Flight{1,12} = 1;
            Flight{1,13} = string(Gate{i,1});
            Assign_Done = 1;    % ��ɷ���
            break
        end
    end
end
end

if Assign_Done == 0   
%% ������˫��˫���Եǻ��ڷ���
for k = 1:size(Gate,1)
    if (Gate{i,5}==0)
        Arrive_Check = (string(Flight{1,5})==string(Gate{i,2}))||(string(Gate{i,2})=="D, I");
        Leave_Check = (string(Flight{1,10})==string(Gate{i,3}))||(string(Gate{i,3})=="D, I");
        Arrive_Check2 = (string(Gate{i,2})=="D, I");
        Leave_Check2 = (string(Gate{i,3})=="D, I");
        
        % ���ݷɻ��ͺ���ɻ���խ�ı������жϷɻ���С
        if (string(Flight{1,11})=="332")||(string(Flight{1,11})=="333")||(string(Flight{1,11})=="33E")||(string(Flight{1,11})=="33H")||(string(Flight{1,11})=="33L")||(string(Flight{1,11})=="773")
            Plane_Type = "W";
        else
            Plane_Type = "N";
        end
        % ���ɻ���С�͵ǻ��ڴ�С�Ƿ�ƥ��
        Type_Check = (Plane_Type==string(Gate{i,4}));
        
        %%��ʼ����
        % �������������Ե�ƥ�䣺�������ͣ��������ͣ��ɻ���С
        % ���ȿ��ǵ������ͣ�����������ȫƥ����Ϊ�����Եĵǻ���
        if (Arrive_Check2&&Leave_Check2&&Type_Check)
            Gate{i,5} = 1;
            Gate{i,6} = Gate{i,6}+1;
            Gate{i,7} = Flight{1,8};
            Flight{1,12} = 1;
            Flight{1,13} = string(Gate{i,1});
            Assign_Done =1; % ��ɷ���
            break
        end
    end
end
end


%% ��󽫾���������������ķɻ���������ʱͣ����
if Assign_Done == 0 
    Flight{1,12}=0;
    Flight{1,13}="temp";
end


    
    