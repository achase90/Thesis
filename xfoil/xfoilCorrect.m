clear all,close all,clc
C1 = [0.020783 -0.002644 0.036290 .011454];
C2 = [0.090236 0.123529 0.079243 .101002];
[e1X,CLa1X,pe1X] = eFunXfoil(1,C2(1))
[e2X,CLa2X,pe2X] = eFunXfoil(1,C2(2))
[e3X,CLa3X,pe3X] = eFunXfoil(1,C2(3))
[eAX,CLaAX,peAX] = eFunXfoil(1,C2(4))

[e1,CLa1,pe1] = eFunXfoil(0,C2(1),C1(1))
[e2,CLa2,pe2] = eFunXfoil(0,C2(2),C1(2))
[e3,CLa3,pe3] = eFunXfoil(0,C2(3),C1(3))
[eA,CLaA,peA] = eFunXfoil(0,C2(4),C1(4))