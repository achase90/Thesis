function V = qbarToV(state)

V = sqrt(double(2*state.qbar.data./state.rho.data));