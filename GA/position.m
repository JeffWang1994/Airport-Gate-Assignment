function chroms = position(chroms, str, Flight, Gate)
%% 登机口分配
%{
1. 读取航班信息，登机口信息，读取初始航班可停靠登机口集合；
2.随机选取集合中的一个登机口，作为该航班的登机口，然后更新该登机口的空闲开始时间，
    使该登机口的空闲开始时间等于该航班的离港时间；
3.以此类推，推出输出可行解。（如果最终还有航班未分配，重来）

输入数据格式：
    chroms为一个存储struct的cells。struct的结构为：
        1.FlightSeNum       1*m
        2.Gate              1*m
        3.unappropriated    1*m
        4.fitness           1*1
    Flight为存储航班信息的cells，其结构为：
        1.航班序列号(修改为1-m数字)
        2.到达日期
        3.到达时间!!!
        4.到达航班号
        5.到达类型!!!
        6.转场时间!!!
        7.出发日期
        8.出发时间!!!
        9.出发航班号
        10.出发类型!!!
        11.飞机大小!!!
    Gate为存储登机口信息的cells，其结构为：
        1.登机口型号!!!
        2.登机口号!!!
        3.到达类型!!!
        4.出发类型!!!
        5.飞机大小!!!
        6.空闲开始时间(需要增添)
%}
disp('position executing...');
[~,n] = size(chroms);   % n为种群大小，可自定义
[~,m] = size(chroms{1,1}.FlightSeNum);  % m为飞机数
[q,~] = size(Gate); % 登机口数
chomTemp = cell(1,1);

%% 登机口初次分配
if strcmp('first', str)
    i=1; % 从种群中的第一个个体开始计算
    while i<=n
        j=1; % 从第一架飞机开始分配
        %% 针对其中一种群的m架飞机进行分配，得到一种分配情况=================================================
        while j<=m
            % 如果已分配，跳过
            if chroms{1,i}.unappropriated(j)==1
                j=j+1;
                continue;
            end
            % 开始随机选取登机口进行尝试
            flag1=1;
            while flag1<q
                % 生成1到q的随机数，随机分配一个机位
                tt = randi([1 round(q)],1,1);
                if ((Flight{j,11}==Gate{tt,5})...    % 飞机大小检查
                        &&((string(Flight{j,5})==string(Gate{tt,3}))||(string(Gate{tt,3})=="D, I"))...  % 到达类型检查
                        &&((string(Flight{j,10})==string(Gate{tt,4}))||(string(Gate{tt,4})=="D, I"))...  % 出发类型检查
                        &&(Flight{j,3}>=(45+Gate{tt,6}))) % 飞机到达时间必须大于登机口空闲开始时间+45
                % if ((Flight{j,11}==Gate{tt,5})&&((Flight{j,5}==Gate{tt,3})||(string(Gate{tt,3})=="D, I"))&&((Flight{j,10}==Gate{tt,4})||(string(Gate{tt,4})=="D, I"))&&(Flight{j,3}>=(45+Gate{tt,6})))
                    chroms{1,i}.Gate(j) = tt;
                    Gate{tt,6} = Flight{j,8};
                    chroms{1,i}.unappropriated(j)=1;
                    %disp(chroms{1,i}.Gate(j))
                    break;  % 跳出flag1循环，进入j=j+1
                end
                flag1 = flag1+1;    %如果当前不满足，则进行继续猜测下一个登机口
            end
            j=j+1;  % 分配完后，进行下一架飞机的分配
        end
        %% 至此，第i种群的所有飞机分配完毕==================================================================
        i=i+1;  
        %% 再此处加上检查机制，检查是否所有的飞机都有登机口了，若没有,重新计算=================================
        %{
        Gate(:,5)=0;    % 设置所有登机口的空闲开始时间为0；
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
%% 交叉、变异后调整以符合约束条件
elseif strcmp('else',str)
    count = 0;
    i=1;
    while i < n
        j=1;
        while j<=m
            % 如果当前航班分配等级为满足约束，更新并跳过
            %if (chroms{1,i}.Gate(j)~=0)
                if (chroms{1,i}.Gate(j)~=0)&&(((Flight{j,11}==Gate{chroms{1,i}.Gate(j),5})...    % 飞机大小检查
                        &&((string(Flight{j,5})==string(Gate{chroms{1,i}.Gate(j),3}))||(string(Gate{chroms{1,i}.Gate(j),3})=="D, I"))...  % 到达类型检查
                        &&((string(Flight{j,10})==string(Gate{chroms{1,i}.Gate(j),4}))||(string(Gate{chroms{1,i}.Gate(j),4})=="D, I"))...  % 出发类型检查
                        &&(Flight{j,3}>=(45+Gate{chroms{1,i}.Gate(j),6})))) % 飞机到达时间必须大于登机口空闲开始时间+45
                    Gate{chroms{1,i}.Gate(j),5}=Flight{j,6}; % 更新登机口空闲时间
                    j=j+1;
                    continue;
                else
                    % 如果当前航班分配登机口不满足约束
                    % 寻找空闲登机口：先找此时间区间占用航班，排除该航班占用登机口，随机分配登机口至指定航班；
                    index0 = 1;
                    onuseHB = ones(1,q); % 占用登机口对应索引值设为1；
                    while index0 <= m     % 针对每一架飞机进行分析
                        % 该判断条件为：要么index0飞机到之前，j飞机飞走了45分钟；要么index飞机飞走了45分钟后，j飞机到达
                        if((Flight{index0,3}>Flight{j,8}+45)||(Flight{index0,8}+45<Flight{j,3}))&&(chroms{1,i}.Gate(index0)~=0)
                            onuseHB(1, chroms{1,i}.Gate(index0))=0;     % 若条件满足，分配这个登机口
                        end
                        index0 = index0+1;
                    end
                    flag1 = 1;
                    while flag1 <= 2*q      % 随机分配登机口到指定航班
                        tt = randi([1 round(q)],1,1);
                    
                        if ((onuseHB(1,tt)==1)...   % tt这个登机口空闲
                                && (Flight{j,11}==Gate{tt,5})...     % 飞机大小检查
                                &&((string(Flight{j,5})==string(Gate{tt,3}))||(string(Gate{tt,3})=="D, I"))...  % 到达类型检查
                            &&((string(Flight{j,10})==string(Gate{tt,4}))||(string(Gate{tt,4})=="D, I"))...  % 出发类型检查
                                && (Flight{j,3}>=(Gate{tt,6}+45)))      % 飞机到达时间必须大于登机口空闲时间+45
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

                
                
        
                    
            
                
                
            
        
        
                    