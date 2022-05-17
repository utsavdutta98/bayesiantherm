clear; clc
load savedataTC0.1.mat
x = data(2:102,1:2:5);
P = data(2:102,2:2:6); 
m = [];
%P = 10*P;
for i = 1:3
    m(i,1) = trapz(x(:,i),x(:,i).*P(:,i))/trapz(x(:,i),P(:,i));
    m(i,2) = sqrt(trapz(x(:,i),((x(:,i)-m(i,1)).^2).*P(:,i))/trapz(x(:,i),P(:,i)));
end

m

figure(1)
for i=1:3
    subplot(1,3,i)
    plot(x(:,i),P(:,i))
end
