%generate classes from training data and tesing it against the test data
%read test videos
path='C:\Users\Rohit Singh\OneDrive\MSCS\Fall 2018\CS6640 Image Processing\Assignments\A7\';
video1=VideoReader(strcat(path,'Videos\bus1.avi')); %training data
video2=VideoReader(strcat(path,'Videos\bus2.avi')); %training data
video3=VideoReader(strcat(path,'Videos\car1.avi')); %training data
video4=VideoReader(strcat(path,'Videos\car2.avi')); %training data
video5=VideoReader(strcat(path,'Videos\truck1.avi')); %training data
video6=VideoReader(strcat(path,'Videos\truck2.avi')); %training data
video7=VideoReader(strcat(path,'Videos\bus3.avi')); %test data
video8=VideoReader(strcat(path,'Videos\car3.avi')); %test data
video9=VideoReader(strcat(path,'Videos\truck3.avi')); %test data
%create an array of test videos for each vehicle type
videos_bus(1,1)=video1;
videos_bus(2,1)=video2;
videos_car(1,1)=video3;
videos_car(2,1)=video4;
videos_truck(1,1)=video5;
 videos_truck(2,1)=video6;
%generating training data
X_bus = CS6640_extract_features(videos_bus);
X_car = CS6640_extract_features(videos_car);
X_truck = CS6640_extract_features(videos_truck);
model_bus = CS6640_build_Bayes(X_bus);
model_car = CS6640_build_Bayes(X_car);
model_truck = CS6640_build_Bayes(X_truck);
class_models(1).mean=model_bus(1).mean;
class_models(1).var=model_bus(1).var;
class_models(2).mean=model_car(1).mean;
class_models(2).var=model_car(1).var;
class_models(3).mean=model_truck(1).mean;
class_models(3).var=model_truck(1).var;
class_models;
sample= [class_models(1).mean'; class_models(2).mean'; class_models(3).mean';];
%generating test data
class_probs=[0.33 0.33 0.34];
x_bus = CS6640_extract_features(video7);
x_bus=(mean(x_bus))';
x_car = CS6640_extract_features(video8);
x_car=(mean(x_car))';
x_truck = CS6640_extract_features(video9);
x_truck=(mean(x_truck))';
%testing the classifier
best_clas_bus = CS6640_Bayes(x_bus,class_probs,class_models); %expected 1
%testing the classifier
best_clas_car = CS6640_Bayes(x_car,class_probs,class_models); %expected 2
%testing the classifier
best_clas_truck = CS6640_Bayes(x_truck,class_probs,class_models); %expected 3