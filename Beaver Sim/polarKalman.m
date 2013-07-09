function regCoeffs = polarKalman(coeffs,state,plane,noise)

%%

xHat(:,1) = [.04;.04];

P = eye(2,2);

Q = zeros(size(P));

    z = coeffs;
    
    errorBnd = errorProp(state,plane,noise);

for i = 2:length(coeffs)

    A = eye(2,2);
    
    %% Estimate current state based on previous observed state
    xHat_ = A*xHat(:,i-1);
    
    %calculate current measurement noise estimate for state, based on
    R = 1e-2*eye(size(A));
    
    R = [errorBnd(i,1) 0;0 errorBnd(i,3)];
    % Calculate variance propagation
    W = eye(size(A));
    
    % calculate variance estimate
    P_ = P(:,:,i-1)+Q;
    
    [y,H] = polarFun(xHat_,z(i,2));

    V = eye(size(P_));
    
    K = P_*H'/(H*P_*H'+R);
    
    xHat(:,i) = xHat_ + K*(z(i,:)'-y);
    P(:,:,i) = (eye(size(P_))-K*H)*P_;
end

regCoeffs = xHat;
