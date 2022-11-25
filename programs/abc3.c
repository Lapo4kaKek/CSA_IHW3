#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

double input() {
    double x;
    scanf("%lf", &x);
    return x;
}

void output(double result) {
    printf("%lf", result);
}

int check(double first, double next) {
    double temp = first / 200;
    if (fabs(first-next) > temp) {
        return 1;
    } else {
        return -1;
    }

}
double Factorial(double n) {
    double result = 1;
    for (int i = 1; i <= n; ++i) {
        result *= i;
    }
    return result;
}
double composition(double a, double n) {
    double result = 1;
    int parameter = 0;
    while(parameter != n) {
        result *= (a-parameter);
        parameter++;
    }
    return result;
}
double work(double x) {
    double result = 0;
    double a = 0.5;
    result += 1 + a*x/1 + a*(a-1)*pow(x, 2) /2 + a*(a-1)*(a-2)*pow(x, 3)/6;
    double respred = result*2;
    double n = 4;
    while(check(result, respred) > 0) {
        respred = result;
        result += composition(0.5, n) * pow(x, n) / Factorial(n);
        ++n;
    }
    return result;
}
int main() {
    double x;
    x = input();
    if (x < -1 || x > 1) {
        printf("%s", "Incorrect input, |x| <= 1");
    } else if (x == 0) {
        printf("%d", 1);
    } else if (x == -1) {
        printf("%d", 0);
    } else {
        double result = work(x);
        output(result);
    }
    return 0;
}
