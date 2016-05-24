%% ICA-��Դ��ICA�����㷨ԭ���matlab�㷨���򣬴��ļ�������
%   ����Ϊ�۲��źţ����Ϊ�����ź�
function Z=ICA(X)

%% --- ȥ��ֵ
    % ����Ϊ�۲����ݵ���Ŀ������Ϊ������Ŀ
    [M,T] = size(X);
    
    % ��ֵ
    average = mean(X')';
    for i=1:M
       X(i,:) = X(i,:) - average(i)*ones(1,T); 
    end

%% �׻�/��
    % ����Э�������
    Cx = cov(X',1);
    
    % ����Cx������ֵ����������
    [eigvector, eigvalue] = eig(Cx);
    % �׻�����
    W = eigvalue^(-0.5)*eigvector';
    Z=W*X;

%% --- ����
    % ����������
    Maxcount = 10000;
    
    % �������
    Critical = 1e-6;
    
    % ��Ҫ���Ƶķ�������
    m=M;
    W=rand(m);
    
    for n=1:m
        % ��ʼȨʸ��
        WP = W(:,n);
        % Y = WP'*Z;
        
        % GΪ�����Ժ�������ȡy^3��
        % G=Y.^3;
        
        % G�ĵ���
        % GG = 3*Y.^2;
        
        count = 0;
        LastWP = zeros(m,1);
        W(:,n) = W(:,n)/norm( W(:,n) );
        
        while abs( WP-LastWP ) & abs( WP+LastWP )>Critical
            % ��������
            count = count +1;
            
            % �ϴε�����ֵ
            LastWP = WP;
            % WP = 1/T*Z*((LastWP'*Z).^3)-3*LastWP;
            
            for i=1:m
               WP(i) = mean( Z(i,:).*(tanh((LastWP)'*Z)) ) - ...
                   (mean(1-(tanh((LastWP))'*Z).^2)).*LastWP(i); 
            end
            WPP = zeros(m,1);
            
            for j=1:n-1
               WPP = WPP + ( WP'*W(:,j))*W(:,j); 
            end
            
            WP = WP - WPP;
            WP = WP/(norm(WP));
            
            if count == Maxcount
               fprintf('δ�ҵ��ź�'); 
            end   
            
        end
        W(:,n) = WP;
    end
Z = W'*Z;
end
