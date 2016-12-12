function v = arithmetic(A)
[M N] = size(A);
sum = 0;
for i = 1:M
    for j = 1:N
        sum = sum + A(i,j);
    end
end
v = sum / (M * N);