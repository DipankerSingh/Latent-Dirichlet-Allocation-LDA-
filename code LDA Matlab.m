function [Phi, Theta, logPw_z]=learn_GibbsLDA(w, K, alpha, beta, max_iter, ...
    burn_in_iter, sampling_lag)
%% initialization
disp('initialization...');
[M,Nd] = size(w);
V = length(unique(w));
NWZ = zeros(V,K) + beta;  % 2D array to maintain Topic-Term Count 
NZM = zeros(K,M) + alpha; % 2D array to maintain Document-Topic Count
NZ = sum(NWZ);			  % just for faster calculations, Topic-Term Sum 
z = zeros(M,Nd);		  % topic assignmed to each word in a document	
Phi = zeros(V,K);		  
Theta = zeros(K,M);

for m=1:M % for each document
    for n=1:Nd % for each word
        z(m,n) = find(mnrnd(1,ones(1,K)/K )==1); % draw topic for each word
        NZM(z(m,n),m) = NZM(z(m,n),m) + 1;
        NWZ(w(m,n),z(m,n)) = NWZ(w(m,n),z(m,n)) + 1;
        NZ(z(m,n)) = NZ(z(m,n)) + 1;
    end;
end;
% initial values of Phi
for k=1:K  
    Phi(:,k) = NWZ(:,k)/NZ(k);
end;

for mm = 1:M
    Theta(:,mm) = NZM(:,mm)/sum(NZM(:,mm));
end;
    

%% sampling and burn-in 
disp('Gibbs sampling starts');

% read_out_Phi and read_out_Theta store the sum of read-out Phi and Theta
read_out_Phi = zeros(V,K);
read_out_Theta = zeros(K,M);
read_out_sampling_num = 0;
logPw_z = zeros(1,max_iter);

for iter = 1:max_iter
    for m=1:M % for each document
        for n=1:Nd % for each word
            % decrease three counts
            NZM(z(m,n),m) = NZM(z(m,n),m) - 1;
            NWZ(w(m,n),z(m,n)) = NWZ(w(m,n),z(m,n)) - 1;
            NZ(z(m,n)) = NZ(z(m,n)) -1;
            % update the posterior distribution of z, p(z_i)
            p  =zeros(1,K);
            for k=1:K
                p(k) = NWZ(w(m,n),k)/NZ(k) * NZM(k,m);
            end;
            p = p/sum(p);
            % draw topic for this word
            z(m,n) = find(mnrnd(1,p)==1); 
            % increase three counts
            NZM(z(m,n),m) = NZM(z(m,n),m) + 1;
            NWZ(w(m,n),z(m,n)) = NWZ(w(m,n),z(m,n)) + 1;
            NZ(z(m,n)) = NZ(z(m,n)) + 1;
        end;
    end;
   
    if ((mod(iter,sampling_lag) == 0) || (iter == 1))

        if iter >= burn_in_iter % read out parameters after burn-in
            read_out_sampling_num = read_out_sampling_num + 1;
            for k=1:K
                read_out_Phi(:,k) = read_out_Phi(:,k) + NWZ(:,k)/NZ(k);
            end;
            for mm = 1:M
                read_out_Theta(:,mm) = read_out_Theta(:,mm) + NZM(:,mm)/sum(NZM(:,mm));
            end;
        end;
    end;
end

% finally, parameters are obtained by averaging the read-out values computed from
% the samples after the burn-in period
Phi = read_out_Phi/read_out_sampling_num;
Theta = read_out_Theta/read_out_sampling_num;



