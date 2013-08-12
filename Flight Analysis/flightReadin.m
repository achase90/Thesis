%% Calculate the current aircraft weight
state.W=planeWeight; %lbf
state.gravity=gravityTerm.signals.values(1)*3.28083989501312;

%% Build eulerAngles and fix units
state.eulerAngles=[eulerAngles.signals.values];
state.eulerAngles(:,3) = unwrap(state.eulerAngles(:,3));
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

%% Build omega and fix units
state.eulerRates=[eulerRates.signals.values];
% state.eulerRates=nan;

%% Build thrust (assume completely axial thrust)
kk = length(engineForcesBody.signals.values);
state.fThrust=[engineForcesBody.signals.values(:,1) zeros(kk,2)]*0.224808943; %convert to lbf

%% Build qbar
state.qbar = qbar.signals.values*0.020885434; %N/m^2 to psf
state.rho = rho.signals.values*0.00194032; %kg/m^3 to slugs/ft^3


%% Build plane struct
plane.Sref=beaver_S*3.28084*3.28084; %m^2 to ft^2