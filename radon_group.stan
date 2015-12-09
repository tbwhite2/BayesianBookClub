data {
  int<lower=0> N; //n obs
  int<lower=1,upper=85> county[N]; //number of distinct counties
  vector[N] u; //county average uranium levels
  vector[N] x; //floors
  vector[N] y; //log radon
} 
parameters {
  vector[85] b; //there are 85 unique counties
  vector[2] beta; //there are 2 unique floor levels
  real mu_b;
  real mu_beta;
  real<lower=0,upper=100> sigma;
  real<lower=0,upper=100> sigma_b;
  real<lower=0,upper=100> sigma_beta;
} 
transformed parameters {
  vector[N] y_hat;

  for (i in 1:N)
    y_hat[i] <- b[county[i]] + x[i] * beta[1] + u[i] * beta[2];
}
model {
  mu_b ~ normal(0, 1); //shouldn't this be the mean and std of the croup (page 257)
  b ~ normal(mu_b, sigma_b); //here is where the group level predictor is being informed by the data

  mu_beta ~ normal(0, 1);
  beta ~ normal(100 * mu_beta, sigma_beta);

  y ~ normal(y_hat, sigma);
}