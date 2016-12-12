function [sum] = energyCalc(a)
sum = 0;
[row col] = size(a);
for k = 1:1:row
    for l = 1:1:col
        sum = sum + abs(a(k,l))^2;
    end
end