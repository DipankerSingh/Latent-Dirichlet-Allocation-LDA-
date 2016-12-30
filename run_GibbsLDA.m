% main program to run the demo of Gibbs sampling for LDA learning
%
% Copyright (C) 2009 Xiaodong Yu, xdyu at umiacs umd edu;
% distributable under GPL, see README.txt

gen_images;

[est_Phi, est_Theta, logPw_z]=learn_GibbsLDA(w, K, alpha, beta, 100, 5, 1, 1, [4 4]);

save('param_est.mat','est_Phi','est_Theta','logPw_z');