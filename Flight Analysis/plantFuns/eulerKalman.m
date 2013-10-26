function state = eulerKalman(state,noise)

%%
p = state.eulerRates(:,1);
q = state.eulerRates(:,2);
r = state.eulerRates(:,3);
phi = state.eulerAngles(:,1);
theta = state.eulerAngles(:,2);
psi = state.eulerAngles(:,3);

% x = [state.windAngles(:,1) state.flankAngle];

xHat(:,1) = [phi(1);theta(1);psi(1)];

P = eye(3,3);

Q = 1e-3*eye(size(P));

for i = 2:length(p)
    z = [phi(i);theta(i);psi(i)];
    
    deltaT = state.time(i)-state.time(i-1);

    A = eye(3,3);
    B = deltaT*eye(3,3);
    
    %% Estimate current state based on previous observed state
    xHat_ = A*xHat(:,i-1)+B*[p(i-1);q(i-1);r(i-1)];
    
    %calculate current measurement noise estimate for state, based on
    R = noise.eulerAngles*pi/180*eye(3,3);

    % Calculate variance propagation
    W = eye(size(A));
    
    % calculate variance estimate
    P_ = P(:,:,i-1)+Q;
    
    H = eye(size(P_));
    V = eye(size(P_));
    
    K = P_/(P_+R);
    
    xHat(:,i) = xHat_ + K*(z-xHat_);
    P(:,:,i) = (eye(size(P_))-K)*P_;
end

state.eulerAngles = xHat';
