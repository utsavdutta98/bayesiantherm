function s = residue(var) 
load net2.mat
load Texp_TLC0.4.mat

%Texp = normrnd(Texp,0.4); % Noise
%save('Texp_TLC0.4.mat','Texp')

T=net2(var);
[T, Texp] = clean(T,Texp);
s=(T-Texp)'*(T-Texp);
end