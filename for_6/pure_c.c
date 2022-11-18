#include <stdio.h>
#include <math.h>

double f(double x) {
    return pow(2.0, pow(x, 2.0) + 1) + pow(x, 2.0) - 4.0;
}

double sign(double x) {
    return x > 0.0 ? 1.0 : -1.0;
}

double bisection_solution() {
    double x_n = 0.0, x_k = 1.0, x_i, eps;
    scanf("%lf", &eps);

    while (x_k - x_n > eps) {
        x_i = x_n + (x_k - x_n) / 2.0;
        if (sign(f(x_n)) != sign(f(x_i))) {
            x_k = x_i;
        } else {
            x_n = x_i;
        }
    }
    return x_i;
}

int main() {
    printf("%.10lf\n", bisection_solution());
    return 0;
}
