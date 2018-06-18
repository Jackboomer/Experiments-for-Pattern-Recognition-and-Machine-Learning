function autoencoder_text()
q=15;
h=0.5;
e=0.0025;
[V,W]=autoencoder(q,h,e);
load sample_autoencoder_text.txt;
sample = sample_autoencoder_text;
% load sample_autoencoder_training.txt;
% sample = sample_autoencoder_training;
sample=sample(:,2:end);
sample = 0.1 * sample;

[a,b]=size(sample);
X=sample;
t=sample;
m=ones(a,1);
m=-1 *m;
X=[X,m];
actual=zeros(1,b);
for i=1:a
u1=X(i,:) * V;
for j=1:q
    a1(j)=1/(1+exp(-u1(j)));
end

if(i==1)
a1=[a1,-1];
end

u2=a1 * W;
for j=1:b
    a2(j)=1/(1+exp(-u2(j)));
end
actual = [actual;a2];
% disp(X(i,1:b));
% disp(a2);
% fprintf('\n');
end
actual=actual(2:end,:);
E=actual - t;
e=sum(abs(E),2)/b;
% figure(1);
% bar(e);
% title('average difference between result and target')
K1=0;
K2=0;
% for j=1:a
%     if(e(j) <0.05)
%             K2=K2+1;
%     end
%     K1=K1+1;
% end
% disp(K1);
% disp(K2);
% disp(K2 /K1);
figure(2);
bar(sum(E.*E/10,2));
title('MSE')
E=sum(E.*E/10,2);
for j=1:a
    if(E(j)<0.0025)
            K2=K2+1;
    end
    K1=K1+1;
end
disp(K1);
disp(K2);
disp(K2/K1);
end