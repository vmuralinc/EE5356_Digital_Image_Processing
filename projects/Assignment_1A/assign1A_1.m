clc;
clear all;

%Set desired L value eg:2,4,8,16,32,64,128
% L=2;
% L=4;
% L=8
% L=16
% L=32;
% L=64;
L=128;
% for count = 1:6
%     L=2^count;
error=1;
rk=zeros(1,L);

%Generate a sample sequence for tk
tk(1)=0;
for i=2:L
    tk(i)=tk(i-1)+(10/(L-1));
end
tk(L+1)=10000;

F1 = @(x) (x./1.5^2).*exp(-power(x,2)./(2*(1.5^2)));
F2 = @(x) x.*(x./1.5^2).*exp(-power(x,2)./(2*(1.5^2)));

%Minimize error
while (error>0.1)
    error=0;
    entropy=0;
    
    %Using tk, calculate rk
    for k=1:1:L
        num=quad(F2,tk(k),tk(k+1));
        den=quad(F1,tk(k),tk(k+1));
        r(k)=num/den;
        entropy=entropy-(den*log2(den));
    end
    
    %Determine error of received samples
    for i=1:L
        error=error+abs((r(i)-rk(i)));
    end
    rk=r;
    
    %Calculate new tk using rk values
    for k=2:L
        tk(k)=(r(k)+r(k-1))/2;
    end
end

%Calculate MSE
MSE=0;
for k=1:L
    F=@(u) (((u-r(k)).^2).*(u./1.5^2).*exp(-(u.^2)./(2*(1.5^2))));
    MSE=MSE+quad(F,tk(k),tk(k+1));
end

%Calculate SNR
SNR=-10*log10(MSE);
tk=tk';
rk=r';
len = length(tk);
tk1 = tk(1:len-1);
% figure(count);
stairs(tk1,rk);
xlabel('tk')
ylabel('rk')
% end