function [] = ganttest(chrom,Flight,Gate)
%% 画甘特图
figure
FlightNum = size(Flight,1);
GateNum = size(Gate,1);
axis([0,24,0,GateNum+1]);
set(gca,'xtick',0:1:24);
set(gca,'ytick',0:1:GateNum);
xlabel('时间'),ylabel('登机口号');
title('登机口分配（占用）甘特图');
% x轴 对应与画图位置的起始坐标x
n_start_time = zeros(1,FlightNum);
for i = 1:FlightNum
    if(Flight{i,2}==19)
        n_start_time(i) = 0;
    elseif (Flight{i,2}==20)
        n_start_time(i) = Flight{i,8}-1440;
    end
end
n_finish_time = zeros(1,FlightNum);
for i = 1:FlightNum
    if(Flight{i,7}==20)
        n_finish_time(i) = Flight{i,8}-1440;
    elseif (Flight{i,7}==21)
        n_finish_time(i) = 1440;
    end
end

n_duration_time = (n_finish_time-n_start_time)/60;
n_start_time = n_start_time/60;
n_gate_start = chrom.Gate;
rec = [0,0,0,0];
for i = 1:FlightNum
    if(n_duration_time(i)>0)&&(n_gate_start(i)~=0)
    rec(1) = n_start_time(i);
    rec(2) = n_gate_start(i)-0.3;
    rec(3) = n_duration_time(i);
    rec(4) = 0.6;
    txt = sprintf('%d',Flight{i,1});
    rectangle('Position',rec,'LineWidth',0.5,'LineStyle','-');
    text(n_start_time(i)+0.2,(n_gate_start(i)),txt,'FontWeight','Bold','FontSize',9);
    end
end

