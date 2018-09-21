function chroms1 = selection(chroms)
%% 选择
disp('selection executing...');
[~,n] = size(chroms);

fit = zeros(1,n);
fitPos = zeros(1,n);
fitnessSum = 0;
chroms1 = chroms;

%{
switch(goal)
    case 1
        for i=1:n
            fit(1,i) = chroms{1,i}.fitness1;
            fitnessSum = fitnessSum + fit(1,i);
        end
    case 2
        for i=1:n
            fit(1,i) = chroms{1,i}.fitness2;
            fitnessSum = fitnessSum + fit(1,i);
        end
    case 0
%}
        % 仅针对问题1，使用单适应度即可
        for i=1:n
            fit(1,i) = chroms{1,i}.fitness;
            fitnessSum = fitnessSum + fit(1,i);
        end
%{
    otherwise
        fprintf('单目标or多目标？参数仔细再看看\n' );
end
%}

% 求适应度比例
for i = 1:n
    fitPos(1,i) = fit(1,i)/fitnessSum;
end

% 进行随机性的选择
% 产生一个随机数，如果该适应度不如随机数，那么删去
% 如果该适应度大于随机数，那么放在index位。
% 有可能将好的删掉，不过没关系，这样才有随机性。
index = 1;
while index<=n
    r = ceil(rand*n);
    if rand<fitPos(1,r)
        chroms1{1,index} = chroms{1,r};
        index = index +1;
    end
end
end

