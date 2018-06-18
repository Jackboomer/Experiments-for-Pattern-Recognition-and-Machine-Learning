
 %get the Connection weight,the threshold 
 %and the deviation from training algorithm
 q=20;
 h=0.5;
[V,W,e]=BP(q,h);    
% load the data of the text sample
load sample_check.txt;  
sample=sample_check;
% load sample_practice.txt;
% sample=sample_practice;
%data preprocessing
sample =0.1 * sample;

%get the attribute and characteristic value
[a,b]=size(sample);
X=sample(:,2:b-1);
t=sample(:,b);
m=ones(a,1);
m=-1 *m;
X=[X,m];
actual=0;

%calculate the output of the text data 
for i=1:a
u1=X(i,:) * V;
for j=1:q
    a1(j)=1/(1+exp(-u1(j)));
end
if(i==1)
a1=[a1,-1];
end
u2=a1 * W;
a2=1/(1+exp(-u2));
actual=[actual,a2];
end

%the  actual output
actual=actual(2:end)';
%the deviation and the mean square error 
%between the actual output and the target output
% E=actual - t;
% E1 = E .* E /2;
%calculate the result about the erroneous classification
% k=0;
% for i=1:a
%     if(abs(E(i))>=0.1)
%         k=k+1;
%     end
% end
%output the results
% figure(1);
% bar(e .* e /2);
% ylabel('Variance of sample_training(1)')
% title('The result of BP training')
% figure(2);
% bar(e);
% ylabel('Difference between target and result')
% title('The result of BP training(2)')
% figure(3);
% bar(E1);
% ylabel('Variance of sample_text')
% title('The result of BP text(1)')
% figure(4)
% bar(E);
% ylabel('Difference between target and the result')
% title('The result of BP text(2)')
% fprintf('The number of the text sample : %d\n',a);
% fprintf('The number of erroneous classification : %d\n',k);
% fprintf('Proportion of erroneous classification : %f\n',k/a);
plotconfusion(t,actual);  %目标输出和检验输出比较画图
