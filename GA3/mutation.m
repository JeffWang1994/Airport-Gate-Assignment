function chroms = mutation(chroms, Gate, mutPos)
%% ���죬�������
disp('mutation executing...');
[~,n] = size(chroms);
[~,m] = size(chroms{1,1}.FlightSeNum);
[q,~] = size(Gate);

indexC = 1;
while indexC<n
    if (randi([1 10],1,1)*mutPos==1)
        indexj = randi([1,m],1,1);  % ������ɱ����
        flag = 1;
        while flag == 1
            tt = randi([1 q],1,1);  % ������ɻ�λ��
            if tt == chroms{1, indexC}.Gate(indexj)
                continue;
            end
            chroms{1,indexC}.Gate(indexj) = tt;
            flag = 0;
        end
    end
    indexC = indexC+1;
end
end
