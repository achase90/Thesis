function state = windKalman(state,noise)

% we're measuring beta directly since we're using a 5hole and not a vane
% beta = atan(tan(state.flankAngle).*cos(state.windAngles(:,1)));

z = [state.windAngles(:,1) state.windAngles(:,2)];
% z = [(state.eulerAngles(:,2)-state.pitchCalc(:,1)) state.eulerAngles(:,3)+state.headingCalc(:,1)];
xHat(1,:) = state.windAngles(1,:);
P(:,:,1) = 1e-1*eye(2,2);
vWind = qbarToV(state);

Q = 1e-2*eye(2,2);


for i = 2:length(z)
    
    %% calculate in structure
    in.V = vWind(i);
    in.ax = state.accel(i,1);
    in.ay = state.accel(i,2);
    in.az = state.accel(i,3);
    in.p = state.eulerRates(i,1);
    in.q = state.eulerRates(i,2);
    in.r = state.eulerRates(i,3);
    in.deltaT = state.time(i)-state.time(i-1);
    %% Estimate current state based on previous observed state
    [xHat_] = alphaFun(xHat(i-1,:),in);
    [~,A] = alphaFun(z(i,:),in);
    
    %calculate current measurement noise estimate for state, based on
    %calculate vBody covariance from filter
    % calculate windAngles covariance
    % Calculate R 
% [sigmaAlpha] = windAnglesCov(state,noise,i);
% R = 5*sigmaAlpha*eye(2,2);
    R = noise.windAngles*pi/180*eye(2,2);
    % Calculate variance propagation
    
    % calculate variance estimate
    P_ = A*P(:,:,i-1)*A'+Q;
    
    H = eye(size(P_));
    V = eye(size(P_));
    
    K = P_/(P_+R);
    
    xHat(i,:) = xHat_ + K*(z(i,:)'-xHat_);
    P(:,:,i) = (eye(size(P_))-K)*P_;
end
state.windAngles = xHat;