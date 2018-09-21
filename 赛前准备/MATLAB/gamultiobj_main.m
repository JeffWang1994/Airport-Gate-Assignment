%% ��Ŀ���Ż��㷨 NSGA-II ����Ӣ���ԵĿ��ٷ�֧�������Ŵ��㷨
% ���㷨��Kalyanmoy Deb�������Ӧ����Ϊ�㷺����Ϊ�ɹ���һ��
% MATLAB�Դ�����gamultiobj���ú����ǻ���NSGA-II�Ľ���һ�ֶ�Ŀ���Ż��㷨
% ����Ŀ¼��
% ��Ӧֵ����m�ļ���gamultiobj_fitness.m
% ������m�ļ���gamultiobj_main.m

%% gamultiobj_main.m
clear
clc
%��Ӧ�Ⱥ������
fitnessfcn = @gamultiobj_fitness;
% ��������
nvars = 2;
% ���ޣ�����
lb = [-5,-5];
ub = [5,5];
% ���Բ���ʽԼ�������Ե�ʽԼ��
A = [];b = [];
Aeq = [];beq = [];
% ���ã����Ÿ���ϵ��paretoFractionΪ0.3����Ⱥ��СpopulationsizeΪ100������������generationΪ200��
% ���ã�ֹͣ����stallGenLimitΪ200����Ӧ�Ⱥ���ƫ��TolFunΪ1e-100������gaplotpareto������Paretoǰ��
options = gaoptimset('paretoFraction',0.3,'populationsize',100,'generations',2000,'stallGenLimit',2000,'TolFun',1e-100,'PlotFcns',@gaplotpareto);
[x,fval] = gamultiobj(fitnessfcn,nvars,A,b,Aeq,beq,lb,ub,options)