function chroms = sortByFitness(varargin)
%{
    ���غ�������Ӧ��ֵ����
    �״β����뾫Ӣ
    ֮���þ�Ӣ�滻�������������

    �����ʽ�����������
        1.sortByFitness(chorms)
        2.sortByFitness(chroms,chromBest)
%}

if nargin == 1
    chroms = varargin{1};
    [~,n] = size(chroms);
    for i=n:-1:2
        % ÿһ�δ������ϵ�����
        for j=1:1:i-1
            if chroms{1,j+1}.fitness > chroms{1,j}.fitness
                temp = chroms{1,j};
                chroms{1,j} = chroms{1,j+1};
                chroms{1,j+1} = temp;
            end
        end
    end
elseif nargin == 2
    chroms = varargin{1};
    chromBest = varargin{2};
    [~,n] = size(chroms);
    chroms = sortByFitness(chroms);
    chroms{1,n} = chromBest;
    chroms = sortByFitness(chroms);
end
end


            