%% Calculate the current aircraft weight
state.W=beaver_mass*2.204622622*ones(length(bodyAccels.time),1); %convert kg to lbf
state.gravity=gravityTerm.signals.values(1)*3.28083989501312;
state.accelerometer = (gravityAccels.signals.values - bodyAccels.signals.values)*3.28083989501312;

%% Build windAngles and fix units
state.alpha=alphaBeta.signals.values(:,1);
state.beta=alphaBeta.signals.values(:,2);

%% Build time
state.time=bodyAccels.time;

%% Calculate accelerations and velocities
state.qbar = qbar.signals.values*0.020885434; %convert N/m^2 to lb/ft^2

%% Build sim output to comapare to
state.drag=aeroForcesWind.signals.values(:,1)*0.224808943; %convert N to lbf
state.side=aeroForcesWind.signals.values(:,2)*0.224808943; %convert N to lbf
state.lift=aeroForcesWind.signals.values(:,3)*0.224808943; %convert N to lbf

try
    state.cDrag=aeroForceCoeffsWind.signals.values(:,1);
    state.cSide=aeroForceCoeffsWind.signals.values(:,2);
    state.cLift=aeroForceCoeffsWind.signals.values(:,3);
    state.cDrag = CDFromSim.signals.values;
    state.cLift = CLFromSim.signals.values;
catch
end

%% Build plane struct
plane.Sref=beaver_S*3.28084*3.28084; %m^2 to ft^2