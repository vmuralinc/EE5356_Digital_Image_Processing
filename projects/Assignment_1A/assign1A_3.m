clc;
clear all;
sigma=1;
sd=1;
L=2; 

g2=0;
g=0;
B=0.1;
q=1;
for i = 1:80
    g1=0;
    for j=1:(L/2)-1
        I = @(u)((u-((2.*j-1).*q)/2).*(u.*exp(-1.*(u.^2)/2)));
        g1 = g1-2.*((2.*j-1).*quad(I,(j-1).*q,j.*q));
    end;
    I1= @(u)((u-((L-1).*q)/2).*(u.*exp(-1.*(u.^2)/2)));
    g2=g2-2.*(L-1).*quad(I1,(L/2-1).*q,10);
    g=g1+g2;
    q = q-B.*g;
end;

tk=zeros(1,L+1);
rk=zeros(1,L+1);
for i=1:L+1
    tk(i)=q.*(i-1);
end;
for i=1:L
    rk(i)=(tk(i)+tk(i+1))/2;
end;
rk(L+1) = rk(L);
a = L*q/2;
MSE=0;
for i=1:L
    I2=@(u)((u-rk(i)).^2.*u.*exp(-1*(u.^2)/2));
    MSE=MSE+quad(I2,tk(i),tk(i+1));
end;
SNR=10*log10(1/MSE);
I3= @(u)(u.*exp(-1.*(u.^2)/2)); 

F=@(u)((u/sigma).*exp(-u.^2/(2*sigma.^2)));
entropy=0;
for i=1:1:L
    a2(i)=quad(F,tk(i),tk(i+1));
    entropy=entropy-(a2(i)*log2(a2(i)));
end

stairs(tk,rk);

