function EF = myEigenFaces(training_set, k)
L_matrix = transpose(training_set)*training_set;
[V,~] = svds(L_matrix, k+3);
V = V(:,3:end);
V_C = training_set*V;
V_C = normc(V_C);
EF = V_C;
end