function state = vBodyKalman(state,noise)

% Assumes GPS is sampled at 5 Hz and accel's sampled at 50 Hz

%%
[accelNED]=inertToBody(state.accel,state.eulerAngles,true);
accelX = accelNED(:,1);
accelY = accelNED(:,2);
accelZ = accelNED(:,3);
% accelX = state.GPSAccel(:,1);
% accelY = state.GPSAccel(:,2);
% accelZ = state.GPSAccel(:,3);

xHat(:,1) = state.GPSSpeed(1,:)';

P = eye(3,3);

Q = 1e-2*eye(size(P));
GPSIndex = 2;
GPSTime = state.time(1);

for i = 2:length(accelX)
    
    deltaT = state.time(i)-state.time(i-1);
    
    A = eye(3,3);
    B = deltaT*eye(3,3);
    
    %% Estimate current state based on previous observed state
    xHat_ = A*xHat(:,i-1)+B*[accelX(i);accelY(i);accelZ(i)];
    
    %calculate current measurement noise estimate for state, based on
    if ~rem(i,10) || i==1; %check if GPS was measured at this time
        R = noise.GPSSpeed*eye(3,3);
        z = state.GPSSpeed(i/10+1,:)';
        GPSIndex = i/10+1;
        GPSTime = state.time(i);
        
    else
        z = state.vBody(GPSIndex,:)';
        R=1e12*eye(3,3);
    end
    
    % Calculate variance propagation
    
    % calculate variance estimate
    P_ = P(:,:,i-1)+Q;
    
    K = P_/(P_+R);
    
    xHat(:,i) = xHat_ + K*(z-xHat_);
    P(:,:,i) = (eye(size(P_))-K)*P_;
end

state.vBodyGPS = xHat';
