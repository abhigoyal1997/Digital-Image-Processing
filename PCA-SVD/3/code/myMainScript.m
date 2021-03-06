%% MyMainScript

tic;
%% Your code here
dim = 92*112;
num_images_train = 32*6;
num_images_test = 32*4;
training_set = zeros(dim, num_images_train);
counter = 1;
train_mean = zeros(dim,1);
train_labels = [];

%% Creating the training set
for person = 1:32
    folder_name = strcat("s",num2str(person));
    folder_path = strcat(strcat('../../att_faces/',folder_name),"/");
    for index = 1:6
        file_path = strcat(folder_path, strcat(num2str(index),'.pgm'));
        image = imread(convertStringsToChars(file_path));
        training_set(:,counter) = image(:);
        counter = counter + 1;
        train_labels = [train_labels person];
        train_mean = train_mean + double(image(:)); 
    end
end

%% Creating the test set
testing_set = zeros(dim, num_images_test);
test_labels = [];
counter = 1;
for person = 1:40
    folder_name = strcat("s",num2str(person));
    folder_path = strcat(strcat('../../att_faces/',folder_name),"/");
    for index = 7:10
        file_path = strcat(folder_path, strcat(num2str(index),'.pgm'));
        image = imread(convertStringsToChars(file_path));
        testing_set(:,counter) = image(:);
        counter = counter + 1;
        if person > 32
            test_labels = [test_labels -1];
        else
            test_labels = [test_labels person];
        end
    end
end

%% Processing the training set
train_mean = train_mean/counter;
training_set = training_set - train_mean;
testing_set = testing_set-train_mean;
threshold = 2500;

%% Computing Accuracies using Eigen Decomposition
[false_positive, false_negative] = face_recog_eig(training_set, testing_set,threshold, test_labels, train_labels);

%% Plotting the Accuracies
false_positive
false_negative

%% Explanation
% To detect faces that are not present inside the datset (training images),
% I use concept of threshold, i.e., it can be assumed that a face that is
% different from all the faces in training set, will incur very high mean
% squared error with all images in the training set. Hence, setting an
% appropriate threshold on mean squared error, to detect such cases will be
% helpful. Here I have set the threshold to 2500.

toc;
