clear all
clc

A = xlsread('Dataset1.xlsx' ,'Sheet1' ,'D2:MF2');
i=1;
B = [];
while i < 341
    B = [B; A(i:i+30)];
    i=i+31;
end