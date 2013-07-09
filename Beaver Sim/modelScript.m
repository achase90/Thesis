clear all,close all,clc

load asbdhc2_init.mat
load NACA0012Adam.mat 

Cx_alpha = 0;
Cx_alpha2 = 0;
Cx_alpha3 = 0;
Cx_df = 0;
Cx_df_alpha = 0;
Cx_dpt = 0;
Cx_dpt2_alpha = 0;
Cx_dr = 0;
Cx_q = 0;

Cz_alpha = 0;
Cz_alpha3 = 0;
Cz_de = 0;
Cz_de_beta = 0;
Cz_df = 0;
Cz_df_alpha = 0;
Cz_dpt = 0;
Cz_q = 0;


Cx0 = 0;
Cz0 = 0;
CD0 = 0.03;
KCL2 = 1/(pi*.7*beaver_b/beaver_c);


Cy0 = 0;
Cy_beta = 0;
Cy_da = 0;
Cy_dr = 0;
Cy_dr_alpha = 0;
Cy_p = 0;
Cy_r = 0;

% beaver_init_pitch = 45*pi/180;
beaver_mass = 1.56;
beaver_S = .2589;
beaver_b = 1.4224;
beaver_c = .3302;
Ix = .1147;
Iy = .0576;
Iz = .1712;
Ixz = .0015;

xme_0(3)=-3000;
u0 = 100/3.28;
v0 = 0;
w0 = 0;
sampleVec = [1/50 0];

windSpeed = 4; %wind speed in m/s