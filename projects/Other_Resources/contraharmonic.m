function v = contraharmonic(A)
[M N] = size(A);
Q = 5;
sum = 0;
sum1 = 0;
for i = 1:M
    for j = 1:N
        sum = sum + (A(i,j)^(Q+1));
        sum1 = sum1 + (A(i,j)^(Q));
    end
end
v = sum/sum1;