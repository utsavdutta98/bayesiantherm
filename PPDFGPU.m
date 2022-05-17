clc, clear all
tic
load samplesTLC0.4.mat
load net2.mat
sigma = 0.35;
noise = 0.35;
noise2 = 0.4;

%%

dataset = samples(900:size(samples(:,1)),:); %Choose 50 points from the samples
samples1 = dataset(:,1); %first varaible numbers
samples2 = dataset(:,2); %second varaible numbers
samples3 = dataset(:,3); %third variable numbers

%sorting the varaibles in ascending order
sort1 = sort(samples1);
sort2 = sort(samples2);
sort3 = sort(samples3);

[X, Y, Z] = ndgrid(sort1,sort2,sort3);

Density = arrayfun(@probab,X,Y,Z);

%% First variable
A = trapz(sort2,trapz(sort3,Density,3),2);
B = trapz(sort1,A);
PPDF_1 = A/B;
%% Second variable
A = trapz(sort1,trapz(sort3,Density,3),1);
B = trapz(sort2,A);
PPDF_2 = A/B;
%% Third variable
A = trapz(sort2,trapz(sort1,Density,1),2);
B = trapz(sort3,A);
PPDF_3 = A/B;

% Dimension setting
PPDF_2 = permute(PPDF_2,[2,1,3]);
PPDF_3 = permute(PPDF_3,[3,2,1]);

%% Save function

L = [sigma noise noise2 0 0 0];
data = [L; sort1 PPDF_1 sort2 PPDF_2 sort3 PPDF_3];
save('savedataTLC0.3.mat','savedata')
%% Plot
figure(1)
subplot(1,3,1)
plot(data(2:101,1),data(2:101,2))
xlabel('Q1')
subplot(1,3,2)
plot(data(2:101,3),data(2:101,4))
title('Marginal PPDF of Q1, Q2 & Q3 with MH-MCMC')
xlabel('Q2')
subplot(1,3,3)
plot(data(2:101,5),data(2:101,6))
xlabel('Q3')
toc

%% Residue
function s = probab(X,Y,Z) 
load net2.mat
load Texp_TLC.mat
sigma = 0.35;
A = [X Y Z]';
T=net2(A);
[T, Texp] = clean(T,Texp);
A=(T-Texp).*(T-Texp);
S = sum(A);
s = exp(-S/(2*sigma^2));
end

