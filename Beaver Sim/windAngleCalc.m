function state = windAngleCalc(state,noise)

state = vBodyKalman(state,noise);
% state.vBodyBody = state.vBodyGPS;
state.vBodyBody = inertToBody(state.vBodyGPS,state.eulerAngles);
state.vBodyBody = state.vBody;
for i=1:length(state.vBodyBody)
        magV = norm(state.vBodyBody(i,:));
state.alphaCalc(i,1) = -atan2(state.vBodyBody(i,2),state.vBodyBody(i,1));
state.betaCalc(i,1) = -asin(state.vBodyBody(i,3)/magV);
end

% state.windAnglesCalc = state.eulerAngles - state.flightPath;
% state.alphaCalc(:,1) = state.eulerAngles(:,2) - state.
% state.betaCalc(:,1) = state.eulerAngles(:,3)-state.flightPath(:,3);
