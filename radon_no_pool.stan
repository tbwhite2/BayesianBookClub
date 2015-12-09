data {
  int<lower=0> N; //number of observations
  int<lower=1,upper=85> county[N]; //85 counties
  vector[N] x; // number of floors
  vector[N] y; // log radon
} 
parameters {
  vector[85] a;
  real beta;
  real<lower=0,upper=100> sigma_a;
  real<lower=0,upper=100> sigma_y;
  real mu_a;
} 
transformed parameters {
  vector[N] y_hat;

  for (i in 1:N)
    y_hat[i] <- beta * x[i] + a[county[i]]; //Fits a separate intercept for each county
}
model {
  beta ~ normal(0, 1);
  mu_a ~ normal(0, 1);
  a ~ normal (mu_a, sigma_a);

  y ~ normal(y_hat, sigma_y);
}