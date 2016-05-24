%% ICA-来源：ICA快速算法原理和matlab算法程序，此文件供调用
%   输入为观察信号，输出为解混后信号
function Z=ICA(X)

%% --- 去均值
    % 行数为观测数据的数目，列数为样本数目
    [M,T] = size(X);
    
    % 均值
    average = mean(X')';
    for i=1:M
       X(i,:) = X(i,:) - average(i)*ones(1,T); 
    end

%% 白化/球化
    % 计算协方差矩阵
    Cx = cov(X',1);
    
    % 计算Cx的特征值和特征向量
    [eigvector, eigvalue] = eig(Cx);
    % 白化矩阵
    W = eigvalue^(-0.5)*eigvector';
    Z=W*X;

%% --- 迭代
    % 最大迭代次数
    Maxcount = 10000;
    
    % 收敛误差
    Critical = 1e-6;
    
    % 需要估计的分量个数
    m=M;
    W=rand(m);
    
    for n=1:m
        % 初始权矢量
        WP = W(:,n);
        % Y = WP'*Z;
        
        % G为非线性函数，可取y^3等
        % G=Y.^3;
        
        % G的导数
        % GG = 3*Y.^2;
        
        count = 0;
        LastWP = zeros(m,1);
        W(:,n) = W(:,n)/norm( W(:,n) );
        
        while abs( WP-LastWP ) & abs( WP+LastWP )>Critical
            % 迭代次数
            count = count +1;
            
            % 上次迭代的值
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
               fprintf('未找到信号'); 
            end   
            
        end
        W(:,n) = WP;
    end
Z = W'*Z;
end
