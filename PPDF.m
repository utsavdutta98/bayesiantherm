clc, clear all
load samplesIR0.3.mat

noise = 1;
noise2 = 0.3;
sigma = 1;
dataset = samples(900:size(samples(:,1)),:); %Choose 50 points from the samples
samples1 = dataset(:,1); %first varaible numbers
samples2 = dataset(:,2); %second varaible numbers
samples3 = dataset(:,3); %third variable numbers

%sorting the variables in ascending order
sort1 = sort(samples1);
sort2 = sort(samples2);
sort3 = sort(samples3);

Prob_1 = []; %first variable probability distribution
A = size(sort1);
for i=1:A(1)
    P2 = [];
    for j=1:A(1)
        P1 = [];
        for k=1:A(1)
            S = residue([sort1(i),sort2(j),sort3(k)]');
            if k == A(1)
                P1 = [P1;0];
            else 
                P1 = [P1; exp(-S/(2*sigma^2))*(sort3(k+1)-sort3(k))];
            end
        end

        if j == A(1)
            P2 = [P2;0];
        else 
            P2 = [P2;sum(P1)*(sort2(j+1)-sort2(j))];
        end
    end
    if i == A(1)
        Prob_1 = [Prob_1;0];
    else 
        Prob_1 = [Prob_1;sum(P2)*(sort1(i+1)-sort1(i))];
    end
end

Prob_1 = Prob_1/sum(Prob_1);

Prob_2 = []; %second variable probability distribution
A = size(sort2);
for i=1:A(1)
    P2 = [];
    for j=1:A(1)
        P1 = [];
        for k=1:A(1)
            S = residue([sort1(j),sort2(i),sort3(k)]');
            if k == A(1)
                P1 = [P1;0];
            else 
                P1 = [P1; exp(-S/(2*sigma^2))*(sort3(k+1)-sort3(k))];
            end
        end

        if j == A(1)
            P2 = [P2;0];
        else 
            P2 = [P2;sum(P1)*(sort1(j+1)-sort1(j))];
        end
    end
    if i == A(1)
        Prob_2 = [Prob_2;0];
    else 
        Prob_2 = [Prob_2;sum(P2)*(sort2(i+1)-sort2(i))];
    end
end

Prob_2 = Prob_2/sum(Prob_2);

Prob_3 = []; %third variable probability distribution
A = size(sort1);
for i=1:A(1)
    P2 = [];
    for j=1:A(1)
        P1 = [];
        for k=1:A(1)
            S = residue([sort1(k),sort2(j),sort3(i)]');
            if k == A(1)
                P1 = [P1;0];
            else 
                P1 = [P1; exp(-S/(2*sigma^2))*(sort1(k+1)-sort1(k))];
            end
        end

        if j == A(1)
            P2 = [P2;0];
        else 
            P2 = [P2;sum(P1)*(sort2(j+1)-sort2(j))];
        end
    end
    if i == A(1)
        Prob_3 = [Prob_3;0];
    else 
        Prob_3 = [Prob_3;sum(P2)*(sort3(i+1)-sort3(i))];
    end
end

Prob_3 = Prob_3/sum(Prob_3);

figure(1)
subplot(1,3,1)
plot(sort1,Prob_1)
subplot(1,3,2)
plot(sort2,Prob_2)
subplot(1,3,3)
plot(sort3,Prob_3)

%% Save function

L = [sigma noise noise2 0 0 0];
data = [L; sort1 Prob_1 sort2 Prob_2 sort3 Prob_3];
save('savedataIR.mat','savedata')