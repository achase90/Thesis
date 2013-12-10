function state = addNoise(state,noise)
if rand<.5
    state.W = state.W + noise.W; % assume offset
else
    state.W = state.W - noise.W; % assume offset
end
state.alpha = state.alpha + normrnd(0,noise.alpha,size(state.alpha));
state.beta = state.beta + normrnd(0,noise.beta,size(state.beta));
state.accelerometer = state.accelerometer + normrnd(0,noise.accelerometer,size(state.accelerometer));
state.qbar = state.qbar + normrnd(0,noise.qbar,size(state.qbar));