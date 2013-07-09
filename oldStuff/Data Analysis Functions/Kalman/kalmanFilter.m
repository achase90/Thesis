function [xk,Pk]=kalmanFilter(A,C,Q,R,Pk_1,x_1)
% xk_ is the a priori estimate of x, estimated using a state space form

% Pk_ is the a priori estimate of the covariance matrix P, estimated using
% a state space form

% Kk is the Kalman gain, calculated such that variance matrix P is minimzed

% xk is the a posteriori estimate of x, and is an average of the a priori
% estimate of the state and the optimal combination of current measurements

% Pk is the a posteriori estimate of the variance of x

% Q is the process noise covariance, I believe this should be the identity
% matrix

% R is the measurement noise covariance ie the variance of each sensor on
% the main diaganol
%% Algorithm:

% Step 1: Compute the estimate of xk_ based on the previous value and the
% system plant: x=Ax+Bu, y=Cx+Du
% 
% Step 2: Compute the estimate of Pk_ based on the previous value of Pk and
% the system plant
% 
% Step 3: Calculate the Kalman gain that minimizes the variance of the
% sensors
% 
% Step 4: Calculate the new xk based on the ideal Kalman gain
% 
% Step 5: Calculate the variance of the new solution
% 
% Step 6: Miller Time
% 
% 
% 
%%
yk=C*x_1;
xk_=A*x_1; % a priori estimate of x
Pk_=A*Pk_1*A'+Q; % a priori estimate of P
Kk=Pk_*C'*inv(C*Pk_*C'+R); % calculate kalman gain based on a priori info
xk=xk_+Kk*(yk-C*xk_); % calculate x
Pk=(eye(size(C))-Kk*C)*Pk_; % calculate covariance P

