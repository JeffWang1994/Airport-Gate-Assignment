%% 云模型建立
clc;
clear all;
close all;
% 每幅图生成N个云滴
N=1500;
% 射击成绩原始数据，这里数据按列存储，所以要转置
Y = [9.5 10.3 10.1 8.1
    10.3 9.7 10.4 10.1
    10.6 8.6 9.2 10.0
    10.5 10.4 10.1 10.1
    10.9 9.8 10.0 10.1
    10.6 8.6 9.2 10.0
    10.4 10.5 10.6 10.3
    10.1 10.2 10.8 8.4
    9.3 10.2 9.6 10.0
    10.5 10.0 10.7 9.9]';
for i = 1:size(Y,1)
    subplot(size(Y,1)/2, 2, i)
    % 调用函数
    [x,y,Ex,En,He] = cloud_transform(Y(i,:),N);
    plot(x,y,'r.');
    xlabel('射击成绩分布/环');
    ylabel('确定度');
    title(strcat('第',num2str(i),' 人射击云模型还原图谱'));
    % 控制坐标轴的范围
    % 统一坐标轴范围才会在云模型形态上具有可比性
    axis([8,12,0,1]);
end
