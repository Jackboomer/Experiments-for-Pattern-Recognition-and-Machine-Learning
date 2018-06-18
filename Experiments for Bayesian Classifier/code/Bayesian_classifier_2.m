X1 = [-3.9847 -3.5549 -1.2401 -0.9780 -0.7932 -2.8531 -2.7605 -3.7287 -3.5414 -2.2692 -3.4549 -3.0752 -3.9934 -0.9780 -1.5799 -1.4885 -0.7431 -0.4221 -1.1186 -2.3462 -1.0826 -3.4196 -1.3193 -0.8367 -0.6579 -2.9683];
X2 = [2.8792 0.7932 1.1882 3.0682 4.2532 0.3271 0.9846 2.7648 2.6588];
P_w1 = 0.9;
P_w2 = 0.1;
lambda11 = 0;
lambda12 = 1;
lambda21 = 6;
lambda22 = 0;

mu1 = mean(X1);
mu2 = mean(X2);
sigma1 = std(X1,1);
sigma2 = std(X2,1);

x = -8:0.01:8;
%compute and plot conditional probabilty density
p_X_w1 = exp(- ((x - mu1) / sigma1) .^2 / 2) / ( sqrt(2 * pi) * sigma1);
p_X_w2 = exp(- ((x - mu2) / sigma2) .^2 / 2) / ( sqrt(2 * pi) * sigma2);

figure(1);
plot(x,p_X_w1);
hold on;
plot(x,p_X_w2);
legend('P(x|w1)','P(x|w2)');

% compute and plot posterior probablity
P_w1_X = p_X_w1 * P_w1 ./ (p_X_w1 * P_w1 + p_X_w2 * P_w2);
P_w2_X = p_X_w2 * P_w2 ./ (p_X_w1 * P_w1 + p_X_w2 * P_w2);

figure(2);
plot(x,P_w1_X);
hold on;
plot(x,P_w2_X);
legend('P(w1|x)','P(w2|x)');


% for i = 1:length(x)
%     if(P_w1_X(i) < P_w2_X(i))
%         fprintf('min error boundry is: ');
%         disp(x);
%         plot(x,P_w1_X,'o');
%         break;
%     end
% end

R_a1_X = lambda11 * P_w1_X + lambda12 * P_w2_X;
R_a2_X = lambda21 * P_w1_X + lambda22 * P_w2_X;

figure(3);
plot(x,R_a1_X);
hold on;
plot(x,R_a2_X);
legend('R(a1|x)','R(a2|x)');

% for i=1:length(x)
%     if(R_a1_X(i) < R_a2_X(i))
%         fprintf('min error boundry is: ');
%         disp(x);
%         plot(x,R_a1_X(i),'o');
%         break;
%     end
% end






        
        
        
        
        
        
        
        
        
        
        