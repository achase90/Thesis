function state = addNoise(state,noise)

state.eulerAngles = state.eulerAngles + normrnd(0,noise.eulerAngles*pi/180,size(state.eulerAngles));
state.eulerRates = state.eulerRates + normrnd(0,noise.eulerRates*pi/180,size(state.eulerRates));
state.windAngles = state.windAngles + normrnd(0,noise.windAngles*pi/180,size(state.windAngles));
state.accel = state.accel + normrnd(0,noise.accel,size(state.accel));
state.qbar = state.qbar + normrnd(0,noise.qbar,size(state.qbar));
% state.GPSSpeed = state.GPSSpeed + normrnd(0,noise.GPSSpeed,size(state.GPSSpeed));

state.gravity = state.gravity+noise.gravity; 