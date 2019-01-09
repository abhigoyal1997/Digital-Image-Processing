function accuracy = face_recog_svd(training_set, testing_set,start_ind, k, test_labels, train_labels)
num_images_test = size(testing_set,2);
L_matrix = transpose(training_set)*training_set;
[V,D] = svds(L_matrix, k+start_ind);
V = V(:,start_ind:end);
V_C = training_set*V;
V_C = normc(V_C);
train_proj = transpose(V_C)*training_set;

%% Predicting labels for test_set
test_proj = transpose(V_C)*testing_set;

predicted_labels = zeros(num_images_test,1);
for index = 1:size(test_proj,2)
    proj = test_proj(:,index);
    distance = (train_proj-proj).^2;
    distance = sum(distance,1);
    [M,I] = min(distance);
    predicted_labels(index,1) = train_labels(I);
end

%% Checking correctness with ground truth
num_correct = 0;
counter = 1;
for item = 1:size(predicted_labels,1)
    if predicted_labels(counter,1) == test_labels(counter)
        num_correct = num_correct + 1;
    end
    counter = counter + 1;
end
accuracy = num_correct/size(testing_set,2);
    
end