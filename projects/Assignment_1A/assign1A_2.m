clc;
clear all;

%Set desired L value eg: 2,4,8,16,32,64,128
L=8

%Initialize rk and tk t zero
rk=zeros(1,L);
tk=zeros(1,L);

%Range of tk=10
tk(L+1)=10;
A=tk(L+1)-tk(1);

%Calculate the tk values from the initial zero sequence and range A
for k=1:L
    F=@(x) power((x/1.5^2).*exp(-(x.^2)/(2*(1.5^2))),(-1/3));
    z=(k/L)*A+tk(1);
    a=quad(F,tk(1),z+tk(1));
    num=A*a;
    den=quad(F,tk(1),tk(L+1));
    tk(k+1)=(num/den)+tk(1);
end

%Calculate corresponding rk values
for k=1:L
    rk(k)=(tk(k)+tk(k+1))/2;
end

%Calculate MSE
F1=@(x) power((x/1.5^2).*exp(-(x.^2)/(2*(1.5^2))),(1/3));
q=quad(F1,tk(1),tk(L+1));
MSE=(1/(12*(L^2))*(q^3));

%Calculate SNR
SNR=-10*log10(MSE);

%Calculate entropy
entropy=0;
F2=@(x) (x/1.5^2).*exp(-(x.^2)/(2*(1.5^2)));
for k=1:L
    a=quad(F2,tk(k),tk(k+1));
    entropy=entropy-(a*log2(a));
end

tk=tk';
rk=rk';
len = length(tk);
tk1 = tk(1:len-1);
stairs(tk1,rk);
xlabel('tk')
ylabel('rk')