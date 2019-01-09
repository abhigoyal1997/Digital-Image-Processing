function im2 = myPCADenoising2(im, p, sigma, k, nb_size)

% Constructing the matrix P with columns as patches of image

[m,n] = size(im);
N = (m-p+1)*(n-p+1);
P = zeros(p*p, N);

for i=1:m-p+1
    for j=1:n-p+1
        P(:,(n-p+1)*(i-1)+j) = reshape(im(i:i+p-1,j:j+p-1),[],1);
    end
end

im2 = single(zeros([m,n]));
im2_pc = single(zeros([m,n]));
nb = (nb_size-1)/2;

Pd = zeros(p*p,N);

for i=1:m-p+1
    for j=1:n-p+1
        pij = (n-p+1)*(i-1)+j;
        
        % selecting k nearest neighbouring patches
        
        is = max(1,i-nb);
        ie = min(m-p+1,i+nb);
        js = max(1,j-nb);
        je = min(n-p+1,j+nb);
        
        r = (is-1:ie-1)'*(n-p+1) + (js:je); % indices of neighbourhood patches
        r = r(:);
        Qi_all = P(:,r);
        [idx,~] = knnsearch(Qi_all', P(:,pij)', 'K', k);
        Qi = Qi_all(:,idx);
        
        % Finding coefficients for noisy image patches in neighbourhood
        
        [V,~] = eig(Qi*Qi');
        alpha = V'*Qi;

        % Calculating the coefficients for denoised image patch Pi and
        % reconstructing the patch

        alpha_a2 = max(0, sum(alpha.^2,2)./k - sigma^2);
        beta = alpha(:,1)./(1+(sigma^2)./alpha_a2);
        
        Pd(:,pij) = V*beta;
    end
end

% Constructing final images from denoised patches

for i=1:m-p+1
    for j=1:n-p+1
        im2(i:i+p-1,j:j+p-1) = im2(i:i+p-1,j:j+p-1) + reshape(Pd(:,(n-p+1)*(i-1)+j),p,p);
        im2_pc(i:i+p-1,j:j+p-1) = im2_pc(i:i+p-1,j:j+p-1) + 1;
    end
end

im2 = im2./im2_pc;

end

