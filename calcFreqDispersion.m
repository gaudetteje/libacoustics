% 
% Dispersion as a function of frequency
%
% See:  H. Bass, H. Bauer, and L. Evans, ?Atmospheric absorption of sound:
%      Analytical expressions,? J. Acoust. Soc. Am., vol. 52, p. 821, 1972.
% valid for sound less than 1 MHz



C_p_dyn = C_p_inf + Cprime / (1 + j*2*pi*f*tau^(p*t));


% eqn. 4
V^2 = (P/rho) * real(C_p_dyn / C_v_dyn);

%or eqn. 9
1/V^2 = (rho/P) * real((C_v_inf + C_vib_dyn) / (C_p_inf / C_vib_dyn));


% eqn 12... argh
Vinf^2 / V^2 = 1 + sum(Ai / (1+(omega*tau_i^(p*s))^2));