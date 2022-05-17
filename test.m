clear all;
clc;

hidlaysize1 = [2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
hidlaysize2 = [2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20];
trainopt = {'trainscg'}; 
maxepoch = [100];
transferfunc = {'logsig' 'tansig'};

x_train = xlsread('Dataset2.xlsx' ,'Sheet1' ,'A2:C2542');
y_train = xlsread('Dataset2.xlsx' ,'Sheet1' ,'D2:MF2542');

bestparameters = gridSearch(x_train,y_train,hidlaysize1,...
                              hidlaysize2,trainopt,maxepoch,transferfunc);


function out = gridSearch(trainX,trainY,param1,param2,param3,param4,param5,varargin)

if(nargin > 4)
[p,q,r,s,t] = ndgrid(param1,param2,1:length(param3),param4,1:length(param5));
pairs = [p(:) q(:) r(:) s(:) t(:)];
% scoreboard = cell(size(pairs,1),4);
else
[p,q] = meshgrid(param1,param2);
pairs = [p(:) q(:)];
% scoreboard = cell(size(pairs,1),3);
end

valscores = zeros(size(pairs,1),1);

for i=1:size(pairs,1)
  setdemorandstream(672880951)
  net = patternnet([pairs(i,1) pairs(i,2)]);
  net.trainFcn = param3{pairs(i,3)};
  net.trainParam.epochs	= pairs(i,4);
  net.layers{2}.transferFcn = param5{pairs(i,5)};
  net.divideParam.trainRatio = 0.70;
  net.divideParam.valRatio = 0.15;
  net.divideParam.testRatio = 0.15;  
  
   vals = crossval(@(XTRAIN, YTRAIN, XTEST, YTEST)NNtrain(XTRAIN, YTRAIN, XTEST, YTEST, net),...
                     trainX, trainY);
   valscores(i) = mean(vals);  

%   net = train(net,trainX,trainY);
%   y_pred = net(valX);    
%   [~,indicesReal] = max(valY, [], 1); %336x1 matrix
%   [~, indicesPredicted] = max(y_pred,[],1);
%   valscores(i) = mean(double(indicesPredicted == indicesReal)); 

end

 [~,ind] = max(valscores);
 out = {pairs(ind,1) pairs(ind,2) param3{pairs(ind,3)} ...
        pairs(ind,4) param5{pairs(ind,5)}};


end

function testval = NNtrain(XTRAIN, YTRAIN, XTEST, YTEST, net)

    net = train(net, XTRAIN', YTRAIN');
    y_pred = net(XTEST');
    [~,indicesReal] = max(YTEST',[],1);
    [~,indicesPredicted] = max(y_pred,[],1);
     testval = mean(double(indicesPredicted == indicesReal));      
end