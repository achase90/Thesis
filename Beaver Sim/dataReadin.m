%% Calculate the current aircraft weight
state.W=beaver_mass*2.204622622; %convert kg to lbf
state.gravity=gravityTerm.signals.values(1)*3.28083989501312;
state.accelerometer = (squeeze(gravityAccels.signals.values)' - bodyAccels.signals.values)*3.28083989501312;

%% Build windAngles and fix units
state.windAngles=[alphaBeta.signals.values];
state.flankAngle = atan(tan(state.windAngles(:,2))./cos(state.windAngles(:,1)));
state.windAnglesDot = windAngleDerivs.signals.values;

%% Build time
state.time=bodyAccels.time;

%% Calculate accelerations and velocities
state.accel=bodyAccels.signals.values*3.28084; %convert from m/s/s to ft/s/s
state.vBody = bodySpeeds.signals.values*3.28084; %convert from m/s to ft/s
% bod
state.GPSSpeed = GPSSpeeds.signals.values*3.28084;
state.GPSTime = GPSSpeeds.time;
state.GPSAccel = GPSAccel.signals.values*3.28084;
% state.vBodyEarth = nan;
state.hDot = hdot.signals.values;


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