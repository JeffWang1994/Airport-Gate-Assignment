function chroms = crossover(chroms, croPos)
%% ���溯��
disp('crossover executing...');
[~,n]=size(chroms);
[~,m]=size(chroms{1,1}.FlightSeNum);

% ȡ�������������Ϊ��Ҫ��ȡ��Ⱦɫ��Ƭ��
flag = 1;
while flag == 1
    t1 = randi([1 round(m)], 1, 1);
    t2 = randi([1 round(m)], 1, 1);
    if (t2>t1)&&(t2<=m)
        flag = 0;
        break;
    end
end

% ����chroms{1,i}��chroms{1,i+1}����Ⱦɫ��Gate��t1:t2�ε�Ⱦɫ��Ƭ��
for i = 1:2:n-mod(n,2)
    if croPos>=rand
        a=chroms{1,i}.Gate(t1:t2);
        b=chroms{1,i+1}.Gate(t1:t2);
        
        chroms{1,i}.Gate(t1:t2)=b;
        chroms{1,i+1}.Gate(t1:t2)=a;
    end
end
end