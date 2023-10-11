#include <stdio.h>
#include <stdlib.h>

struct string {
    int len;
    int size;
    char* adr;
};

struct string int_string(int num) {
    struct string str;
    char* buf = malloc(10);
    
    int i = 9;
    int sign = 0;
    if(num < 0) {
        num = -num;
        sign = 1;
    }

    while(num > 0) {
        buf[i] = 48 + num % 10;
        num /= 10;
        i--;
    }

    int size = 9 - i + sign;
    str.len = size;
    str.size = size;
    str.adr = malloc(size);

    if(sign) {
        str.adr[0] = 45;
    } else {
        i++;
    }

    for(int j = sign; j < size; j++) {
        str.adr[j] = buf[i + j];
    }
    free(buf);

    return str;
}

int main() {
    struct string s = int_string(-42345910);
    
    return 0;
}