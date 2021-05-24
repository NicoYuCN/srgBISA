function [res, dst] = fish_bb(org_img)

% org_img = imread(filename);

if (size(org_img,3)==3),
    org_img = double(rgb2gray(org_img));
else
    org_img = double(org_img);
end


lvl = 3;
[r,c] = size(org_img);
blk = 4;

[bands] = dwt_cdf97(org_img,lvl);

subbands = cell(3,3);
r0 = floor(r/2/blk)-1;
c0 = floor(c/2/blk)-1;

dst = zeros(r0,c0);

for idx = 1:r0
    for jdx = 1:c0
        for m = 1:3
            for n = 1:3
                subbands{m}{n} = bands{m}{n}(1 + (idx-1)*blk/(2^(m-1)):(idx+1)*blk/(2^(m-1)), 1 + (jdx-1)*blk/(2^(m-1)):(jdx+1)*blk/(2^(m-1)));
            end
        end
        dst(idx, jdx) = map_index(subbands);
    end
end

tmp = sort(dst(:),'descend');
lth = length(tmp);
res = sqrt(mean(tmp(1:max(1,floor(lth/100))).^2));


function ss = ssq(bands)

alpha = 0.8;

lh_img = bands{1}.^2;
hl_img = bands{2}.^2;
hh_img = bands{3}.^2;

E_lh = log10(1+mean(lh_img(:)));
E_hl = log10(1+mean(hl_img(:)));
E_hh = log10(1+mean(hh_img(:)));

ss = alpha*E_hh + (1-alpha) *(E_lh + E_hl)/2;


function dst = map_index(bands)

alpha =[4  2  1];

ss3 = ssq(bands{3});

ss2 = ssq(bands{2});

ss1 = ssq(bands{1});

ss = [ss1 ss2 ss3];

dst = sum(ss.*alpha);