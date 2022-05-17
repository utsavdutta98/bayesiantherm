clear all
clc

sigma = 0.35;
samples = [];
Q1=8; Q2=4; Q3=1;

i=0;
var = [Q1 Q2 Q3]';

while i<1000
    var1 = normrnd(var,var/20);
    
    Pnew = exp(-residue(var1)/(2*sigma^2));
    Pold = exp(-residue(var)/(2*sigma^2));
    A = min(1, Pnew/Pold);
    Z = (var-[7 3 0.8]')./[3 3 2.2]';
    if A>rand()                   
        var = var1;
        i=i+1;
        samples = [samples; var'];
    end
end

%save('samplesTLC.mat','samples')  
figure(1)
subplot(1,3,1)
plot(1:size(samples(:,1)),samples(:,1))
subplot(1,3,2)
plot(1:size(samples(:,2)),samples(:,2))
subplot(1,3,3)
plot(1:size(samples(:,3)),samples(:,3))
