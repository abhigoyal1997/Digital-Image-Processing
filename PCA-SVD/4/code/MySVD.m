function [U,V,sv] = MySVD(A)

[m,n] = size(A);

[U,~] = eigs(A*A',m,'largestabs');
[V,D] = eigs(A'*A,n,'largestabs');

U = normc(U);
V = normc(V);

if m < n
    D = D(1:m,:);
elseif m > n
    D = [D;zeros(m-n,n)];
end

S = sqrt(D);

A = A*V;
B = U*S;

C = repmat(sum((A - B).^2) > 0.0005, n, 1);

V = V - 2*V.*C;

sv = diag(S);

end

