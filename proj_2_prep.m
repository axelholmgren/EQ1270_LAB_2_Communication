%% load
kth = load('kth.jpg');
hamilton = load('hamilton.jpg');
load('spydata.mat')
load('training.mat');
%% encode pic prep 1
%pic = imread('kth.jpg');
raw_pic = imread('hamilton.jpg');
pic = imresize(raw_pic,[1024 1024]);

%[key,cPic] = encoder(pic);

%% Make some fucking noise! prep 2
h = [1 0.7 0.7];
dist_key = conv(received, h,'same');

%% Equalizer
% Equalizer 
L = 1;
for i = 1:16;
A = [];
correct_bits = training(L+1:32);

for row = 0:31-L;
    for column = 0:L;
        A(row+1,column+1) = received(L+1-column+row);
    end;
end;
size(A)
g = A\correct_bits;


reconstructed_key = filter(g,1,received);
mapped_key = sign(reconstructed_key);
if L == 7
    best_key = mapped_key;
    end4
recon_pic = decoder(mapped_key, cPic);

% Differentiated elements
e = mapped_key(1:32) - training;
E = nnz(e);

subplot(5,8,i);
image(recon_pic);
title(['L= ',num2str(L),'E= ' ,num2str(E)]);
L = L+1;
end


%% flip some mf bits :))
stepsize = 50;
endnr = 750;
for j = 0:stepsize:endnr
    % create random
    vector_length=length(best_key);
    random_amount = j;
    gauss_rand = rand([random_amount, 1]);
    
    random_nrs = gauss_rand*vector_length;
    random_elements = round(random_nrs);

    % bitflip best key
    key_to_flip = best_key;
    for k = random_elements;
       key_to_flip(k) = (-1)*key_to_flip(k);
    end
    flipped_key = key_to_flip;

    % print pictures
    recon_flipped_pic = decoder(flipped_key, cPic);
    x = round(j./stepsize) + 1;
    subplot(5,8,x);
    image(recon_flipped_pic);
    title(['BF = ', num2str(j)]);
    L = L+1;
end
