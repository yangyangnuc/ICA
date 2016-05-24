%% 主程序， 原始信号产生，观察信号和解混信号的作图
clc,clear all,close all;

%% 原始信号产生
% 样本数目
N=200;

% 正弦信号
n = 1:N;
s1 = 2*sin( 0.02*pi*n );

% 方波信号
t=1:N;
s2 = 2*square(100*t,50);

% 锯齿信号
a=linspace(1,-1,25);
s3=2*[a,a,a,a,a,a,a,a,];

% 随机信号
s4 = rand(1,N);

S=[s1;s2;s3;s4];

% 随机产生一个混合
A = rand(4,4);
X=A*S;

%% 原始信号波形图
figure(1),
subplot(4,1,1),plot(s1),axis([0 N -5 5]),title('源信号');
subplot(4,1,2),plot(s2),axis([0 N -5 5]);
subplot(4,1,3),plot(s3),axis([0 N -5 5]);
subplot(4,1,4),plot(s4),axis([0 N -5 5]);


%% 观察信号 （混合后信号）波形图
figure(2),
subplot(4,1,1),plot(X(1,:)),title('观察信号（混合后信号）');
subplot(4,1,2),plot(X(2,:))
subplot(4,1,3),plot(X(3,:))
subplot(4,1,4),plot(X(4,:))
xlabel('Time/ms');

%% ICA解混
Z = ICA(X);
figure(3),
subplot(4,1,1),plot(Z(1,:)),title('解混后信号');
subplot(4,1,2),plot(Z(2,:))
subplot(4,1,3),plot(Z(3,:))
subplot(4,1,4),plot(Z(4,:))
xlabel('Time/ms');


pause;
close all;
