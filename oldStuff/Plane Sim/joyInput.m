function [roll pitch yaw throttle]=joyInput(joyObj)
roll=axis(joyObj,1);
pitch=axis(joyObj,2);
yaw=axis(joyObj,3);
throttle=-(axis(joyObj,4)-1)/2;
end
