%% load
kth = load('kth.jpg');
training = load('training.mat');
%% encode pic prep 1 
pic = imread('kth.jpg');

[key,cPic] = encoder(pic);

%% Make some fucking noise! prep 2
h = [1 0.7 0.7];
dist_key = conv(key, h,'same');

%% Equalizer
L = 11;

A = [];
correct_bits = training(L+1:31);

for row = 0:31-L;
    for column = 0:L;
        A(row+1,column+1) = dist_key(L+1-column+row);
    end;
end;
g = correct_bits/A;



%% decode pic prep 3
dPic = decoder(sign(dist_key), cPic);
axis square;
image(dPic);

%% HHHH
dsist_key=[];
for n = 1:length(key)
    
    conv_vector = [key()]
    conv_result = conv(h,conv_vector)
    dsist_key= [dsist_key, conv_result]
end

%% test
for row = 0:31-L;
    for column = 0:L;
        A(row+1,column+1) = dist_key(L+1-column+row);
    end;
end;
g = correct_bits/A;