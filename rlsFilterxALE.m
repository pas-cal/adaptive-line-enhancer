function [thetahat, xhat, Pbar] = rlsFilterxALE(y,N,delay,lambda)

M = length(y);

% Initialisation of Y(n), P(n), Pbar(n), K(n), xhat(n) and thetahat(n)
Y = zeros(N,1);
Pn = 1e4 .* eye(N);
Pbar = zeros(M,1); % Frobenius form of each P array
xhat = zeros(M,1); 
thetahat = zeros(N, N+M);
K = zeros (N,M); % storing values of K and thetahat for every iteration


yinit = [zeros(delay,1); y]; %initialisation y(n) with zero padding to let the filter start initialising before the audio starts

% Following algorithm from lecture notes
for n=1:1:M-1
    % Update Y(n) with previous samples from yinit(n)
    Y = circshift(Y,-1);
    Y(end) = yinit(n);

    % Generate xhat = noise from signal using the RLS estimator yhat(n+1) = Y^{T}(n+1) * thetahat (n)
    xhat(n) = y(n+1) - Y.'*thetahat(:,n); % using nth column of vector

    % Update K, P, Pbar and thetahat

    K(:,n) = (Pn * Y)/(lambda + Y.'*Pn*Y);
    Pn = (1/lambda) * (Pn - K(:,n)*Y.'* Pn);
    thetahat(:,n+1) = thetahat(:,n) + K(:,n)*xhat(n);

    Pbar = norm(Pn,"fro");
end