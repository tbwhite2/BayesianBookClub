
data {
int N;
vector[N] units;
vector[N] temp;
}

transformed data {  
vector[N] log_units;        
log_units <- log(units);
}

parameters {
real alpha;
real beta;
real tau;
}

transformed parameters {
real sigma;
sigma <- 1.0 / sqrt(tau);
}

model{
// Model
log_units ~ normal(alpha + beta * temp, sigma);
// Priors
alpha ~ normal(0.0, 1000.0);
beta ~ normal(0.0, 1000.0);
tau ~ gamma(0.001, 0.001);
}

generated quantities{
vector[N] units_pred;
for(i in 1:N)
units_pred[i] <- exp(normal_rng(alpha + beta * temp[i], sigma));
}
