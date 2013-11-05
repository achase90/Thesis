for i=1:length(mag)
    magNorm(i,:) = mag(i,:)/norm(mag(i,:));
end

for i=1:length(mag)
    accelNorm(i,:) = accel(i,:)/norm(accel(i,:));
end

R = magNorm'*pinv(accelNorm');

magNormCalc = (R*accelNorm')';
figure(1)
scatter(magNorm(:,1),magNormCalc(:,1))
hold on
XX = linspace(min(magNorm(:,1)),max(magNorm(:,1)));
plot(XX,XX)
axis equal
grid on

figure(2)
scatter(magNorm(:,2),magNormCalc(:,2))
axis equal
hold on
XX = linspace(min(magNorm(:,2)),max(magNorm(:,2)));
plot(XX,XX)
grid on

figure(3)
scatter(magNorm(:,3),magNormCalc(:,3))
hold on
XX = linspace(min(magNorm(:,3)),max(magNorm(:,3)));
plot(XX,XX)
axis equal
grid on


gravity = magNorm*R';
roll = acosd(gravity(:,1));
pitch = acosd(gravity(:,2));
yaw = acosd(gravity(:,3));

