% main program to run the demo of Gibbs sampling for LDA learning
%


gen_images;

[est_Phi, est_Theta, logPw_z]=learn_GibbsLDA(w, K, alpha, beta, 100, 5, 1, 1, [4 4]);

save('param_est.mat','est_Phi','est_Theta','logPw_z');
