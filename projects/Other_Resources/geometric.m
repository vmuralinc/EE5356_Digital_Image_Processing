function v = geometric(A)
[M N] = size(A);
prod = 1;
for i = 1:M
    for j = 1:N
        prod = prod * A(i,j);
    end
end
v = prod ^ (1/(M * N));