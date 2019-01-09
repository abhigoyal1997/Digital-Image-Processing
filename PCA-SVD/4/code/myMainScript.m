%% Reading and displaying the test matrix
A = dlmread('data.txt');

fprintf('The matrix A =\n\n');
disp(A);

%% Finding SVD
tic;
[U,V,sv] = MySVD(A);
toc;

fprintf('The matrix U i.e., left singular vectors of A = \n\n');
disp(U);

fprintf('The matrix V i.e., right singular vectors of A = \n\n');
disp(V);

fprintf('The non-zero singular values of A = \n\n');
disp(sv');

%% Reconstructing the matrix A and verifying the decomposition
tic;
[m,n] = size(A);

% Constructing the diagonal matrix S from non-zero singular values of A
if m < n
    S = [diag(sv) zeros(m,n-m)];
elseif m > n
    S = [diag(sv);zeros(m-n,n)];
end

Ar = U*S*V'; % Reconstruction of A
toc;

fprintf('The reconstructed matrix = \n\n');
disp(Ar);

err = mse(A,Ar);
fprintf('The mean squared error b/w the original and reconstructed A matrix = %f\n', err);