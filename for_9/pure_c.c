#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

int my_stoi(char *str) {
    int result = 0;
    for (int i = 0; i < strlen(str); ++i) {
        result *= 10;
        result += str[i] - '0';
    }
    return result;
}

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
    return 1.0 / (1000 + (rand() % 99999000));
}

int main(int argc, char** argv) {
    if (argc == 3) {
        double eps;
        FILE* file_in = fopen(argv[1], "r");
        if (file_in != NULL) {
            FILE* file_out = fopen(argv[2], "w");
            fscanf(file_in,"%lf", &eps);

	    fprintf(file_out, "%.10lf\n", bisection_solution(eps));

	    fclose(file_in);
            fclose(file_out);
        } else if (strcmp(argv[1], "-r") == 0) {
            eps = random_eps();

            int iterations = my_stoi(argv[2]);

            clock_t t0 = clock();

            for (int i = 0; i < iterations; ++i) {
                bisection_solution(eps);
            }

            printf("%.30lf\n", (double) (clock() - t0) / CLOCKS_PER_SEC);
        } else {
            printf("Invalid input\n");
        }
    } else {
        printf("Invalid input\n");
    }
    return 0;
}
