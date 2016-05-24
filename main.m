%% ������ ԭʼ�źŲ������۲��źźͽ���źŵ���ͼ
clc,clear all,close all;

%% ԭʼ�źŲ���
% ������Ŀ
N=200;

% �����ź�
n = 1:N;
s1 = 2*sin( 0.02*pi*n );

% �����ź�
t=1:N;
s2 = 2*square(100*t,50);

% ����ź�
a=linspace(1,-1,25);
s3=2*[a,a,a,a,a,a,a,a,];

% ����ź�
s4 = rand(1,N);

S=[s1;s2;s3;s4];

% �������һ�����
A = rand(4,4);
X=A*S;

%% ԭʼ�źŲ���ͼ
figure(1),
subplot(4,1,1),plot(s1),axis([0 N -5 5]),title('Դ�ź�');
subplot(4,1,2),plot(s2),axis([0 N -5 5]);
subplot(4,1,3),plot(s3),axis([0 N -5 5]);
subplot(4,1,4),plot(s4),axis([0 N -5 5]);


%% �۲��ź� ����Ϻ��źţ�����ͼ
figure(2),
subplot(4,1,1),plot(X(1,:)),title('�۲��źţ���Ϻ��źţ�');
subplot(4,1,2),plot(X(2,:))
subplot(4,1,3),plot(X(3,:))
subplot(4,1,4),plot(X(4,:))
xlabel('Time/ms');

%% ICA���
Z = ICA(X);
figure(3),
subplot(4,1,1),plot(Z(1,:)),title('�����ź�');
subplot(4,1,2),plot(Z(2,:))
subplot(4,1,3),plot(Z(3,:))
subplot(4,1,4),plot(Z(4,:))
xlabel('Time/ms');


pause;
close all;
