close all,clc

for i=1:length(altitude.signals.values)
    [~,rho(i)] = stdatm(altitude.signals.values(i),1);
        v(i) = norm(state.vBody(i,:));
    qbarMine(i) = .5*rho(i)*v(i)^2;
end
plot(qbarMine)
hold all
plot(state.qbar);

figure(2)
plot(rho)

figure(3)
plot(v)