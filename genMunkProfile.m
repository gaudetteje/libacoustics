function c = genMunkProfile(z)

epsilon = 0.00737;
z_tilde = 2*(z - 1300)/1300;

c = 1500*(1+epsilon*(z_tilde - 1 + exp(-z_tilde)));