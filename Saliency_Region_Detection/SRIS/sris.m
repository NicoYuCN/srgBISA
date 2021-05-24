% Copyright (c) 2020, Aditi Joshi and Kwang Nam Choi, Chung-Ang University
% All rights reserved.
% Freely distributed for educational and research purposes only.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% Cite: A. Joshi, M. S. Khan, S. Soomro, A. Niaz, B. S. Han and K. N. Choi, 
%       "SRIS: Saliency-Based Region Detection and Image Segmentation of COVID-19 
%       Infected Cases," IEEE Access, vol. 8, pp. 190487-190503, 2020.

function phi = sris(phi_0,g,beta,epsilon,mu,timestep,cha_c0,image,c)
phi = phi_0;
[vx, vy] = gradient(g);
color_dif = cha_c0;
phi = NeumannBoundCond(phi);
[phi_x, phi_y] = gradient(phi); 
s = sqrt(phi_x.^2 + phi_y.^2);
smallNumber = 1e-10;
Nx = phi_x./(s+smallNumber);
Ny = phi_y./(s+smallNumber);
curvature = div(Nx,Ny);
distRegTerm = 4*del2(phi);
diracPhi = Dirac(phi,epsilon);
edgeTerm = diracPhi.*(vx.*Nx+vy.*Ny) + diracPhi.*g.*curvature;

f1 = median(image(phi>=0));
c2 = mean(c(2,:));
c1 = mean(c(1,:));

A = image-((c1.^2+ f1.^2 -2*c2.^2)/(2*c1 + 2*f1 -4*c2));
spf = sign(2*c1 + 2*f1 - 4*c2)*sign(A).* A.^2;
spf = spf/max(abs(spf(:))) .*s;
spf = (spf >= 0) - ( spf< 0); 

phi=phi + timestep*(mu*distRegTerm + beta*edgeTerm.*spf + diracPhi.*g.*color_dif);

function f = div(nx,ny)
[nxx,~] = gradient(nx);
[~,nyy] = gradient(ny);
f = nxx+nyy;

function g = NeumannBoundCond(f)
[nrow,ncol] = size(f);
g = f;
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);