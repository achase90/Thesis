function output = eulerKalman(input)
%%
p = input.rollRate.data;
q = input.pitchRate.data;
r = input.yawRate.data;
phi = input.roll.data;
theta = input.pitch.data;
psi = input.yaw.data;

xHat(:,1) = [phi(1);theta(1);psi(1)];

P = eye(3,3);

Q = 1e-3*eye(size(P));

for i = 2:length(p)
    z = [phi(i);theta(i);psi(i)];
    
    deltaT = double(input.time.data(i)-input.time.data(i-1));

    A = eye(3,3);
    B = deltaT*eye(3,3);
    
    %% Estimate current state based on previous observed state
    xHat_ = A*xHat(:,i-1)+B*[p(i-1);q(i-1);r(i-1)];
    
    %calculate current measurement noise estimate for state, based on
eulerAngleNoise = [input.roll.noise input.pitch.noise input.yaw.noise];
    R = diag(eulerAngleNoise*pi/180,0);
%todo: check units. do we need to convert from degrees to radians here?

    % Calculate variance propagation
    W = eye(size(A));
    
    % calculate variance estimate
    P_ = P(:,:,i-1)+Q;
    
    H = eye(size(P_));
    V = eye(size(P_));
    
    K = P_/(P_+R);
    
    xHat(:,i) = xHat_ + K*(z-xHat_);
    P(:,:,i) = (eye(size(P_))-K)*P_; %todo:check size of this matrix, I don't think you need to index that deeply
end

eulerAngles = xHat';
output.roll.data = eulerAngles(:,1);
output.pitch.data = eulerAngles(:,2);
output.yaw.data = eulerAngles(:,3);

%todo: translate the P matrix into new estimates of the variance, so we can
%pass those out of this function into the wind angle kalman filter
output.roll.noise = P(1,1,1);
output.pitch.noise = P(2,2,1);
output.yaw.noise = P(3,3,1);
