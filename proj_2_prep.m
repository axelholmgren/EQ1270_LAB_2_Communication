%% load
kth = load('kth.jpg');
training = load('training.mat');
spydata = load("spydata.mat")
%% encode pic prep 1 
pic = imread('kth.jpg');

[key,cPic] = encoder(pic);

%% Make some fucking noise! 


%% decode pic
dPic = decoder(key, cPic);
axis square;
image(dPic);

%% 