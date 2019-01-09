%% MyMainScript
tic;

%% Creating the training set (Yale Database)
dim = 192*168;
training_set = [];
folders = dir('../../CroppedYale/');
train_labels = [];
train_mean = zeros(dim,1);
folders = folders(3:end);
folders = {folders([folders.isdir]).name};
person = 1;
for folder = folders
    if folder == ".DS_Store"
        continue
    end
    counter = 0;
    folder_path = strcat('../../CroppedYale/',folder);
    folder_path = strcat(folder_path,"/");
    files = dir(folder_path);
    files = {files.name};
    files = files(3:end);
    for item = files
        if item == ".DS_Store"
            continue
        end
        file_name = strcat(folder_path,item);
        image = imread(convertStringsToChars(file_name));
        training_set = [training_set image(:)];
        train_mean = train_mean + double(image(:));
        train_labels = [train_labels person];
        counter = counter + 1;
        if counter == 40
            break;
        end
    end
    person = person + 1;
end

%% Processing the training set
train_mean = train_mean/size(training_set,2);
training_set = double(training_set) - train_mean;
im = training_set(:,1);

%% Reconstructing the face and getting Eigenfaces
k_vals = [2,10,20,50,75,100,125,150,175];
k_max = max(k_vals);

EF = myEigenFaces(training_set, k_max);
im_p = EF'*im;

ims = zeros(dim,9);
im_a = bsxfun(@times, EF, im_p');
count = 1;
for k = k_vals
    ims(:,count) = train_mean + sum(im_a(:,1:k),2);
     count = count + 1;
end

%% Plotting the Reconstructed Faces and EigenFaces

imshow(mat2gray(reshape(im,[192,168]))); % Original face

% Reconstructed faces
count = 1;
figure;
for k = k_vals
    subplot(3,3,count), imshow(mat2gray(reshape(ims(:,count), [192,168])));
    count = count+1;
end

% Eigenfaces corresponding to highest 25 eigenvalues
figure;
for i = 1:25
    subplot(5,5,i), imshow(mat2gray(reshape(EF(:,i), [192,168])));
end
    
toc;
