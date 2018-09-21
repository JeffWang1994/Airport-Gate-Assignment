function chroms = position(chroms, str, Flight, Gate)
%% �ǻ��ڷ���
%{
1. ��ȡ������Ϣ���ǻ�����Ϣ����ȡ��ʼ�����ͣ���ǻ��ڼ��ϣ�
2.���ѡȡ�����е�һ���ǻ��ڣ���Ϊ�ú���ĵǻ��ڣ�Ȼ����¸õǻ��ڵĿ��п�ʼʱ�䣬
    ʹ�õǻ��ڵĿ��п�ʼʱ����ڸú�������ʱ�䣻
3.�Դ����ƣ��Ƴ�������н⡣��������ջ��к���δ���䣬������

�������ݸ�ʽ��
    chromsΪһ���洢struct��cells��struct�ĽṹΪ��
        1.FlightSeNum       1*m
        2.Gate              1*m
        3.unappropriated    1*m
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
%}
disp('position executing...');
[~,n] = size(chroms);   % nΪ��Ⱥ��С�����Զ���
[~,m] = size(chroms{1,1}.FlightSeNum);  % mΪ�ɻ���
[q,~] = size(Gate); % �ǻ�����
chomTemp = cell(1,1);

%% �ǻ��ڳ��η���
if strcmp('first', str)
    i=1; % ����Ⱥ�еĵ�һ�����忪ʼ����
    while i<=n
        j=1; % �ӵ�һ�ܷɻ���ʼ����
        %% �������һ��Ⱥ��m�ܷɻ����з��䣬�õ�һ�ַ������=================================================
        while j<=m
            % ����ѷ��䣬����
            if chroms{1,i}.unappropriated(j)==1
                j=j+1;
                continue;
            end
            % ��ʼ���ѡȡ�ǻ��ڽ��г���
            flag1=1;
            while flag1<q
                % ����1��q����������������һ����λ
                tt = randi([1 round(q)],1,1);
                if ((Flight{j,11}==Gate{tt,5})...    % �ɻ���С���
                        &&((string(Flight{j,5})==string(Gate{tt,3}))||(string(Gate{tt,3})=="D, I"))...  % �������ͼ��
                        &&((string(Flight{j,10})==string(Gate{tt,4}))||(string(Gate{tt,4})=="D, I"))...  % �������ͼ��
                        &&(Flight{j,3}>=(45+Gate{tt,6}))) % �ɻ�����ʱ�������ڵǻ��ڿ��п�ʼʱ��+45
                % if ((Flight{j,11}==Gate{tt,5})&&((Flight{j,5}==Gate{tt,3})||(string(Gate{tt,3})=="D, I"))&&((Flight{j,10}==Gate{tt,4})||(string(Gate{tt,4})=="D, I"))&&(Flight{j,3}>=(45+Gate{tt,6})))
                    chroms{1,i}.Gate(j) = tt;
                    Gate{tt,6} = Flight{j,8};
                    chroms{1,i}.unappropriated(j)=1;
                    %disp(chroms{1,i}.Gate(j))
                    break;  % ����flag1ѭ��������j=j+1
                end
                flag1 = flag1+1;    %�����ǰ�����㣬����м����²���һ���ǻ���
            end
            j=j+1;  % ������󣬽�����һ�ܷɻ��ķ���
        end
        %% ���ˣ���i��Ⱥ�����зɻ��������==================================================================
        i=i+1;  
        %% �ٴ˴����ϼ����ƣ�����Ƿ����еķɻ����еǻ����ˣ���û��,���¼���=================================
        %{
        Gate(:,5)=0;    % �������еǻ��ڵĿ��п�ʼʱ��Ϊ0��
        for jj = 1:m
            if chroms{1,i-1}.Gate(jj) == 0
                chroms{1,i-1}.unappropriated(:) = 1;
                i = i-1;
                break;
            end
        end
        %}
        %% ==============================================================================================
    end
%% ���桢���������Է���Լ������
elseif strcmp('else',str)
    count = 0;
    i=1;
    while i < n
        j=1;
        while j<=m
            % �����ǰ�������ȼ�Ϊ����Լ�������²�����
            %if (chroms{1,i}.Gate(j)~=0)
                if (chroms{1,i}.Gate(j)~=0)&&(((Flight{j,11}==Gate{chroms{1,i}.Gate(j),5})...    % �ɻ���С���
                        &&((string(Flight{j,5})==string(Gate{chroms{1,i}.Gate(j),3}))||(string(Gate{chroms{1,i}.Gate(j),3})=="D, I"))...  % �������ͼ��
                        &&((string(Flight{j,10})==string(Gate{chroms{1,i}.Gate(j),4}))||(string(Gate{chroms{1,i}.Gate(j),4})=="D, I"))...  % �������ͼ��
                        &&(Flight{j,3}>=(45+Gate{chroms{1,i}.Gate(j),6})))) % �ɻ�����ʱ�������ڵǻ��ڿ��п�ʼʱ��+45
                    Gate{chroms{1,i}.Gate(j),5}=Flight{j,6}; % ���µǻ��ڿ���ʱ��
                    j=j+1;
                    continue;
                else
                    % �����ǰ�������ǻ��ڲ�����Լ��
                    % Ѱ�ҿ��еǻ��ڣ����Ҵ�ʱ������ռ�ú��࣬�ų��ú���ռ�õǻ��ڣ��������ǻ�����ָ�����ࣻ
                    index0 = 1;
                    onuseHB = ones(1,q); % ռ�õǻ��ڶ�Ӧ����ֵ��Ϊ1��
                    while index0 <= m     % ���ÿһ�ܷɻ����з���
                        % ���ж�����Ϊ��Ҫôindex0�ɻ���֮ǰ��j�ɻ�������45���ӣ�Ҫôindex�ɻ�������45���Ӻ�j�ɻ�����
                        if((Flight{index0,3}>Flight{j,8}+45)||(Flight{index0,8}+45<Flight{j,3}))&&(chroms{1,i}.Gate(index0)~=0)
                            onuseHB(1, chroms{1,i}.Gate(index0))=0;     % ���������㣬��������ǻ���
                        end
                        index0 = index0+1;
                    end
                    flag1 = 1;
                    while flag1 <= 2*q      % �������ǻ��ڵ�ָ������
                        tt = randi([1 round(q)],1,1);
                    
                        if ((onuseHB(1,tt)==1)...   % tt����ǻ��ڿ���
                                && (Flight{j,11}==Gate{tt,5})...     % �ɻ���С���
                                &&((string(Flight{j,5})==string(Gate{tt,3}))||(string(Gate{tt,3})=="D, I"))...  % �������ͼ��
                            &&((string(Flight{j,10})==string(Gate{tt,4}))||(string(Gate{tt,4})=="D, I"))...  % �������ͼ��
                                && (Flight{j,3}>=(Gate{tt,6}+45)))      % �ɻ�����ʱ�������ڵǻ��ڿ���ʱ��+45
                            chroms{1,i}.Gate(j) = tt;
                            Gate{tt,6} = Flight{j,8};
                            chroms{1,i}.unappropriated(j) = 1;
                            j = j+1;
                            break;
                        end
                        flag1 = flag1+1;
                        chroms{1,i}.Gate(j)=0;
                        chroms{1,i}.unappropriated(j)=0;
                    end
                    j = j+1;
                end
            end
        %end
        GateDisp = chroms{1,i}.Gate;
        %GateDisp
        i = i+1;
        %{
        Gate{:,5}=0;
        for jj= 1:m
            if chroms{1,i-1}.unappropriated(jj)==1
                chomTemp{1,1} = chroms{1,i-1};
                chomTemp = Gate(chomTemp,'first',Flight,Gate,timeInter);
                chroms{1,i-1}=chomTemp{1,1};
                count = count+1;
                break;
            end
        end
        %}
    end
    %count
end
end

                
                
        
                    
            
                
                
            
        
        
                    