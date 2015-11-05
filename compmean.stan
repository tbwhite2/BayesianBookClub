
// Two-sample Comparison of Means

data { 
int<lower=1> n1;
int<lower=1> n2;
vector[n1] x;
vector[n2] y;
}

parameters {
real mu;
real sigmatmp;
real delta;
} 

transformed parameters {
real<lower=0> sigma;
real alpha;
sigma <- fabs(sigmatmp);
alpha <- delta * sigma;
}

model {
// Delta, mu, and sigma Come From (Half) Cauchy Distribution
mu ~ cauchy(0, 1);
sigmatmp ~ cauchy(0, 1);
delta ~ cauchy(0, 1);
// Data
x ~ normal(mu + alpha / 2, sigma);
y ~ normal(mu - alpha / 2, sigma);
}