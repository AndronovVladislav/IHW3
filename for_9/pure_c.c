#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

double f(double x) {
    return pow(2.0, pow(x, 2.0) + 1) + pow(x, 2.0) - 4.0;
}

double sign(double x) {
    return x > 0.0 ? 1.0 : -1.0;
}

double bisection_solution(double eps) {
    double x_n = 0.0, x_k = 1.0, x_i;

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

double random_eps() {
    srand(time(NULL));
    return 1.0 / (rand() % 10000);
}

int main(int argc, char** argv) {
    FILE* file_in = fopen(argv[1], "r");
    FILE* file_out = fopen(argv[2], "w");
    double eps;

    if (argc == 3 && file_in != NULL) {
        scanf("%lf", &eps);
        fprintf(file_out, "%.10lf\n", bisection_solution(eps));
        fclose(file_in);
    } else if (argc == 3 && strcmp(argv[1], "-r") == 0) {
        eps = random_eps();

        clock_t t0 = clock();
        double result = bisection_solution(eps);
        printf("%.30lf\n", (double) (clock() - t0) / CLOCKS_PER_SEC);

        fprintf(file_out, "%.10lf\n", result);
    } else {
        printf("Invalid input\n");
    }
    fclose(file_out);
    return 0;
}
