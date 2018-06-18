function [] = linLinear_Classification_picture(N,e)
data1 = rand(1,N);
data2 = unifrnd (0.01,1,1, N);

for i = 1:N
    x1(i) = data1(i);
    y1(i) = 3*data1(i) + 3 * data2(i);
end
plot(x1,y1,'rs');
hold on;
for i = 1:N
    x2(i) = data1(i);
    y2(i) = 3*data1(i) - 3 * data2(i);
end
plot(x2,y2,'*');
hold on;

X1=ones(2,length(x1));
X2=ones(2,length(x2));
for i = 1:length(x1)
    X1(1,i) = x1(i);
    X1(2,i) = y1(i);
end
for i = 1:length(x2)
    X2(1,i) = x2(i);
    X2(2,i) = y2(i);
end
X1(3,: ) = 1;
X2(3,: ) = 1;

w  = rand(3,1);
t1 =  1;
t2 = -1;
X1 = X1 * t1;
X2 = X2 * t2;


type = 1;
n = 0;
while type
    flag = 0;
    for i = 1:N
        if( (w' * X1(:,i)) <= 0)
            w = w + e * X1(:,i);
            flag = flag + 1;
        end
        n = n + 1;
    end
    for i = 1:N
        if(w' * X2(:,i) <= 0)
            w = w + e * X2(:,i);
            flag = flag + 1;
        end
         n = n + 1;
    end
    if(flag == 0)
        type = 0;
    end
end
               
x = -8:0.01:8;
y =-(w(1)/w(2))*x-w(3)/w(2);
% x*w1+y*w2+w0=0,w=[w1;w2;w0]
plot(x,y,'r');
hold on;
fprintf('解向量为: ');
disp(w);
 fprintf('迭代次数为: ');
 disp(n);
  fprintf('样本数量为: ');
 disp(N);
  fprintf('学习rate为: ');
 disp(e);
 axis([0,1,-4,6])        
end