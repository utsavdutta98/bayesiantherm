clear all
clc

input = xlsread('Dataset2.xlsx' ,'Sheet1' ,'A2:C3004'); input = input';
output = xlsread('Dataset2.xlsx' ,'Sheet1' ,'D2:MF3004'); output = output';

trainfn = 'trainscg';
net2 = feedforwardnet([5,11],trainfn);

net2.divideParam.trainRatio = 70/100;
net2.divideParam.valRatio = 15/100;
net2.divideParam.testRatio = 15/100;

net2.trainParam.epochs = 3000;

try
    nnet.internal.cnngpu.reluForward(1);
catch ME
end

net2 = train(net2,input,output,'useGPU','yes');

%save netnew net2
