function [false_positive, false_negative] = face_recog_eig(training_set, testing_set, threshold, test_labels, train_labels)
num_images_test = size(testing_set,2);
L_matrix = transpose(training_set)*training_set;
[V,D] = eigs(L_matrix, 100);
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
    distance = distance.^(0.5);
    [M,I] = min(distance);
    if M < threshold
        predicted_labels(index,1) = train_labels(I);
    else
        predicted_labels(index,1) = -1;
    end
end

%% Checking correctness with ground truth
num_correct = 0;
counter = 1;
false_positive = 0;
false_negative = 0;
for item = 1:size(predicted_labels,1)
    if predicted_labels(counter,1) == -1 && test_labels(counter) > 0
        false_negative = false_negative + 1;
    elseif predicted_labels(counter,1) > 0 && test_labels(counter) == -1
        false_positive = false_positive + 1;
    end
    counter = counter + 1;
end

    
end