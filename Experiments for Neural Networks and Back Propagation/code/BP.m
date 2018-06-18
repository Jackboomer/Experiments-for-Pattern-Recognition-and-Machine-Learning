function [V,W,E]=BP(q,h)
% load the data of the training sample
load sample_practice.txt;
sample=sample_practice;
sample = 0.1*sample;

[a,b]=size(sample);
X=sample(:,2:b-1);
t=sample(:,b);
e=0.0001;
V=rand(b-1,q);
W=rand(q+1,1);
m=ones(a,1);
m=-1 *m;
X=[X,m];
actual=0;
K1=0;
K2=0;
for i=1:a
for g=1:400
u1=X(i,:) * V;
for j=1:q
    a1(j)=1/(1+exp(-u1(j)));
    K2=K2 + 1;
end

if(g==1 && i==1)
a1=[a1,-1];
end

u2=a1 * W;
a2=1/(1+exp(-u2));

delta2 = (t(i)-a2)*exp(-u2)/((1+exp(-u2))^2);
W= W + h * delta2 * a1';
for j=1:q+1
    delta1(j)=delta2 * W(j) * exp(-u2)/((1+exp(-u2))^2);
    K2=K2 + 1;
end
V = V + h * X(i,:)' * delta1(1:q);
if( ((t(i)-a2)^2)/2<e)
    break;
end
K2=K2 + 1;
end
actual=[actual,a2];
K1=K1 + 1;
K2=K2 + 1;
end
fprintf('The number of the training samples : %d\n',a);
fprintf('Number of iterative cycle: %d\n',K1);
fprintf('Number of iterations: %d\n ',K2);
actual=actual(2:end)';
E=actual - t;
end