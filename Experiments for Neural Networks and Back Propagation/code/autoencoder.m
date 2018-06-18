function [V,W]=autoencoder(q,h,e)
% function [V,W]=autoencoder()
% q=20;
% h=0.5;
% e=0.001;
load sample_autoencoder_training.txt;
sample=sample_autoencoder_training;
sample=sample(:,2:end);
sample = 0.1*sample;

[a,b]=size(sample);
% disp(a);
X=sample;
t=sample;
V=rand(b+1,q);
W=rand(q+1,b);
m=ones(a,1);
m=-1 *m;
X=[X,m];

for i=1:10:(a-9)
for g=1:5000
u1=X(i:i+9,:) * V;
for k=1:10
for j=1:q
    a1(k,j)=1/(1+exp(-u1(k,j)));
end
end

if(g==1 && i==1)
a1=[a1,-ones(10,1)];
end

u2=a1 * W;
for k=1:10
for j=1:b
    a2(k,j)=1/(1+exp(-u2(k,j)));
end
end

for k=1:10
for j=1:b
    delta2(k,j)=(t(i+k-1,j)-a2(k,j))*exp(-u2(k,j))/((1+exp(-u2(k,j)))^2);
end
end
W= W + h * a1' * delta2;

for k=1:10
for j=1:q
    delta1(k,j)= delta2(k,:) * W(j,:)' * exp(-u1(k,j))/((1+exp(-u1(k,j)))^2);
end
end
V = V + h * X(i:i+9,:)' * delta1;

E=a2-t(i:i+9,:);
E= E.*E/10;
ave_E= sum(sum(E))/10;
if(ave_E<e)
    break;
end
end
% disp(X(i,1:b));
% disp(ave_E);
% fprintf('\n');
end
end