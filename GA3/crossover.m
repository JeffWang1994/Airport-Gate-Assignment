function chroms = crossover(chroms, croPos)
%% 交叉函数
disp('crossover executing...');
[~,n]=size(chroms);
[~,m]=size(chroms{1,1}.FlightSeNum);

% 取两项随机数，作为需要截取的染色体片段
flag = 1;
while flag == 1
    t1 = randi([1 round(m)], 1, 1);
    t2 = randi([1 round(m)], 1, 1);
    if (t2>t1)&&(t2<=m)
        flag = 0;
        break;
    end
end

% 交换chroms{1,i}和chroms{1,i+1}两条染色体Gate段t1:t2段的染色体片段
for i = 1:2:n-mod(n,2)
    if croPos>=rand
        a=chroms{1,i}.Gate(t1:t2);
        b=chroms{1,i+1}.Gate(t1:t2);
        
        chroms{1,i}.Gate(t1:t2)=b;
        chroms{1,i+1}.Gate(t1:t2)=a;
    end
end
end