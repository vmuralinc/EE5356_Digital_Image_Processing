function v = harmonic(A)
[M N] = size(A);
sum = 0;
for i = 1:M
    for j = 1:N
        sum = sum + (1/A(i,j));
    end
end
v = (M * N)/sum;