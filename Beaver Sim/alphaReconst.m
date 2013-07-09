function alphaOut = alphaReconst(state)

[accelInert] = inertToBody(state.accel,state.eulerAngles,true);

hDot = trapz(state.time,-accelInert(:,3));

V = sqrt(2*state.qbar/0.0018400);

alphaOut = state.eulerAngles(:,2) - asin(hDot./V);