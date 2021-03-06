function [alphaP,betaP,alphaPNoise,betaPNoise] = windKalman(input)

output = input; %structs are generally the same, so copy them


% we're measuring beta directly since we're using a 5hole and not a vane
% beta = atan(tan(state.flankAngle).*cos(state.windAngles(:,1)));

z = [input.alphaP.data input.betaP.data];

xHat(1,:) = [input.alphaP.data(1) input.betaP.data(1)];
P(:,:,1) = 1e-1*eye(2,2);
vWind = input.qbar.data;

Q = 1e-2*eye(2,2);


for i = 2:length(z)
    
    %% calculate in structure
    in.V = vWind(i);
    in.ax = input.accelX.data(i);
    in.ay = input.accelY.data(i);
    in.az = input.accelZ.data(i);
    in.p = input.rollRate.data(i);
    in.q = input.pitchRate.data(i);
    in.r = input.yawRate.data(i);
    in.deltaT = double(input.time.data(i)-input.time.data(i-1));
    
    %% Estimate current state based on previous observed state
    in.V = 1; %todo: get rid of this. this is just to make it run for now.
    [xHat_] = alphaFun(xHat(i-1,:),in);
    [~,A] = alphaFun(z(i,:),in);
    
    % Calculate R 
    windAngleNoise = [input.alpha.noise(i) input.beta.noise(i)]; %todo:check the units on this
    R = diag(windAngleNoise,0);
   
    % calculate variance estimate
    P_ = A*P(:,:,i-1)*A'+Q;
    
    H = eye(size(P_));
    V = eye(size(P_));
    
    K = P_/(P_+R);
    
    xHat(i,:) = xHat_ + K*(z(i,:)'-xHat_);
    P(:,:,i) = (eye(size(P_))-K)*P_;
end
windAngles = xHat;
alphaP = windAngles(:,1);
betaP = windAngles(:,2);
alphaPNoise=squeeze(P(1,1,:));
betaPNoise = squeeze(P(2,2,:));