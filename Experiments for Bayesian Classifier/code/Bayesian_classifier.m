mu = [2 3];
SIGMA = [1 0.5; 0.5 2];
X1 = mvnrnd(mu,SIGMA,100);
mu = [7 8];
SIGMA = [ 1 0.25; 0.25 1 ];
X2 = mvnrnd(mu,SIGMA,100);

mu = [2 8];
SIGMA = [ 1 0.75; 0.75 1];
X3 = mvnrnd(mu,SIGMA,100);

figure(1);
plot(X1(:,1),X1(:,2),'o');hold on;
plot(X2(:,1),X2(:,2),'*');hold on;
plot(X3(:,1),X3(:,2),'rs');

P_w1 = 0.6;
P_w2 = 0.3;
P_w3 = 0.1;

mu1 = mean(X1);
mu2 = mean(X2);
mu3 = mean(X3);
sigma1 = std(X1,1);
sigma2 = std(X2,1);
sigma3 = std(X3,1);

[x, y] = meshgrid(-2 : 0.1 : 12);

p_X_w1 = reshape(mvnpdf([x(:), y(:)], mu1, sigma1),size(x));
p_X_w2 = reshape(mvnpdf([x(:), y(:)], mu2, sigma2),size(x));
p_X_w3 = reshape(mvnpdf([x(:), y(:)], mu3, sigma3),size(x));
figure(2);
surf(x,y,p_X_w1);hold on;
surf(x,y,p_X_w2);hold on;
surf(x,y,p_X_w3);
legend('P(x|w1)','P(x|w2)','P(x|w3)');

P_w1_X = p_X_w1 * P_w1 ./ (p_X_w1 * P_w1 + p_X_w2 * P_w2 + p_X_w3 * P_w3);
P_w2_X = p_X_w2 * P_w2 ./ (p_X_w1 * P_w1 + p_X_w2 * P_w2 + p_X_w3 * P_w3);
P_w3_X = p_X_w3 * P_w3 ./ (p_X_w1 * P_w1 + p_X_w2 * P_w2 + p_X_w3 * P_w3);

figure(3);
surf(x,y,P_w1_X);hold on;
surf(x,y,P_w2_X);hold on;
surf(x,y,P_w3_X);
legend('P(w1|x)','P(w2|x)','P(w3|x)');

boundary_result1 = zeros(size(x));
for i = 1:size(x,1)
for j = 1:size(x,1)
[~,Class] = min([P_w1_X(i,j) P_w2_X(i,j) P_w3_X(i,j)]);
boundary_result1(i,j) = Class;
end
end
figure(4);
surf(x,y,boundary_result1);

lambda = [0 3 1; 2 0 1; 3 6 0];
R_a1_X = lambda(1, 1) * P_w1_X + lambda(1, 2) * P_w2_X + lambda(1, 3) * P_w3_X;
R_a2_X = lambda(2, 1) * P_w1_X + lambda(2, 2) * P_w2_X + lambda(2, 3) * P_w3_X;
R_a3_X = lambda(3, 1) * P_w1_X + lambda(3, 2) * P_w2_X + lambda(3, 3) * P_w3_X;
figure(5);
surf(x,y,R_a1_X);hold on;
surf(x,y,R_a2_X);hold on;
surf(x,y,R_a2_X);
legend('R(a1|x)','R(a2|x)','R(a3|x)');

boundry_result2 = zeros(size(x));
for i = 1:size(x,1)
for j = 1:size(x,1)
[~,Class] = min([R_a1_X(i,j) R_a2_X(i,j) R_a2_X(i,j)]);
boundry_result2(i,j) = Class;
end
end
figure(6);
surf(x,y,boundry_result2);
