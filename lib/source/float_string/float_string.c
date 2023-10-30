#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>
#include <string.h>

struct utf8_string {
    int len;
    int* chars;
};

const unsigned long FLOAT_POW5_INV_SPLIT[] = {
    576460752303423489, 461168601842738791, 368934881474191033, 295147905179352826, 
    472236648286964522, 377789318629571618, 302231454903657294, 483570327845851670, 
    386856262276681336, 309485009821345069, 495176015714152110, 396140812571321688,
    316912650057057351, 507060240091291761, 405648192073033409, 324518553658426727,
    519229685853482763, 415383748682786211, 332306998946228969, 531691198313966350,
    425352958651173080, 340282366920938464, 544451787073501542, 435561429658801234,
    348449143727040987, 557518629963265579, 446014903970612463, 356811923176489971,
    570899077082383953, 456719261665907162, 365375409332725730
};

const unsigned long FLOAT_POW5_SPLIT[] = {
    1152921504606846976, 1441151880758558720, 1801439850948198400, 2251799813685248000,
    1407374883553280000, 1759218604441600000, 2199023255552000000, 1374389534720000000,
    1717986918400000000, 2147483648000000000, 1342177280000000000, 1677721600000000000,
    2097152000000000000, 1310720000000000000, 1638400000000000000, 2048000000000000000,
    1280000000000000000, 1600000000000000000, 2000000000000000000, 1250000000000000000,
    1562500000000000000, 1953125000000000000, 1220703125000000000, 1525878906250000000,
    1907348632812500000, 1192092895507812500, 1490116119384765625, 1862645149230957031,
    1164153218269348144, 1455191522836685180, 1818989403545856475, 2273736754432320594,
    1421085471520200371, 1776356839400250464, 2220446049250313080, 1387778780781445675,
    1734723475976807094, 2168404344971008868, 1355252715606880542, 1694065894508600678,
    2117582368135750847, 1323488980084844279, 1654361225106055349, 2067951531382569187,
    1292469707114105741, 1615587133892632177, 2019483917365790221
};

int pow5bits(int e) {
    return e == 0 ? 1 : (int) ((e * 23219280 + 9999999) / 10000000);
}

int mulShift(int m, long factor, int shift) {
    int factor_low = (int) factor;
    int factor_high = (int) (factor >> 32);

    long bits0 = (long) m * factor_low;
    long bits1 = (long) m * factor_high;

    long sum = (bits0 >> 32) + bits1;
    long shiftedSum = sum >> (shift - 32);
    return (int) shiftedSum;
}

int mulPow5InvDivPow2(int m, int q, int j) {
    return mulShift(m, FLOAT_POW5_INV_SPLIT[q], j);
}

int mulPow5divPow2(int m, int i, int j) {
    return mulShift(m, FLOAT_POW5_SPLIT[i], j);
}

int pow5Factor(int val) {
    int i = 0;
    while(val > 0) {
        if(val % 5 == 0) {
            return i;
        }

        val /= 5;
        i++;
    }
    return 0;
}

int multipleOfPow5(int x, int p) {
    return pow5Factor(x) >= p;
}

int decimalLength(int val) {
    int len = 10;
    int factor = 1000000000;
    for(; len > 0; len--) {
        if(val >= factor) {
            break;
        }
        factor /= 10;
    }
    return len;
}

const int strNaN[] = { 110, 97, 110 };
const int strPosInf[] = { 105, 110, 102 };
const int strNegInf[] = { 45, 105, 110, 102 };
const int strPosZero[] = { 48, 46, 48 };
const int strNegZero[] = { 45, 48, 46, 48 };

struct utf8_string normalString(float num, unsigned int bits) {
    int exponent = (bits & 2139095040) >> 23;
    int mantissa = bits & 8388607;

    int e2;
    int m2;
    if(exponent == 0) {
        e2 = -149;
        m2 = mantissa;
    } else {
        e2 = exponent - 150;
        m2 = mantissa | 8388608;
    }

    int mv = 4 * m2;
    int mp = 4 * m2 + 2;
    int mm = 4 * m2 - (m2 != 8388608 || exponent <= 1 ? 2 : 1);
    e2 -= 2;

    int dp, dv, dm;
    int e10;
    bool dp_itz, dv_itz, dm_itz;
    int lastRemDigit = 0;
    if(e2 >= 0) {
        int q = (int) (e2 * 0.3010299);
        int k = 58 + pow5bits(q);
        int i = q + k - e2;

        dv = (int) mulPow5InvDivPow2(mv, q, i);
        dp = (int) mulPow5InvDivPow2(mp, q, i);
        dm = (int) mulPow5InvDivPow2(mm, q, i);

        if(q != 0 && ((dp - 1) / 10 <= dm / 10)) {
            int l = 58 + pow5bits(q - 1);
            lastRemDigit = mulPow5InvDivPow2(mv, q - 1, q - e2 - 1 + l) % 10;
        }
        e10 = q;

        dp_itz = multipleOfPow5(mp, q);
        dv_itz = multipleOfPow5(mv, q);
        dm_itz = multipleOfPow5(mm, q);
    } else {
        int q = (int) (e2 * -0.69897);
        int i = -e2 - q;
        int k = pow5bits(i) - 61;
        int j = q - k;

        dv = (int) mulPow5divPow2(mv, i, j);
        dp = (int) mulPow5divPow2(mp, i, j);
        dm = (int) mulPow5divPow2(mm, i, j);

        if(q != 0 && ((dp - 1) / 10 <= dm / 10)) {
            j = q - pow5bits(i + 1) + 60;
            lastRemDigit = mulPow5divPow2(mv, i + 1, j) % 10;
        }
        e10 = q + e2;

        dp_itz = 1 >= q;
        dv_itz = (q < 23) && (mv & ((1 << (q - 1)) - 1)) == 0;
        dm_itz = (mm % 2 != 1 ? 1 : 0) >= q;
    }

    int dpLen = decimalLength(dp);
    int expon = e10 + dpLen - 1;

    bool sciNot = !((expon >= -3) && (expon < 7));

    int removed = 0;
    if(dp_itz) {
        dp--;
    }

    while(dp / 10 > dm / 10) {
        if(dp < 100 && sciNot) {
            break;
        }

        dm_itz &= dm % 10 == 0;
        dp /= 10;

        lastRemDigit = dv % 10;
        dv /= 10;
        dm /= 10;

        removed++;
    }

    if(dm_itz) {
        while(dm % 10 == 0) {
            if (dp < 100 && sciNot) {
                break;
            }

            dp /= 10;
            lastRemDigit = dv % 10;

            dv /= 10;
            dm /= 10;

            removed++;
        }
    }

    if(dv_itz && lastRemDigit == 5 && dv % 2 == 0) {
        lastRemDigit = 4;
    }

    int output = dv + ((dv == dm && !dm_itz) || (lastRemDigit >= 5) ? 1 : 0);
    int outLen = dpLen - removed;
    
    int* result = (int*) malloc(15 * sizeof(int));
    int idx = 0;
    if(num < 0) {
        result[idx++] = 45;
    }

    struct utf8_string str;
    if(sciNot) {
        for(int i = 0; i < outLen - 1; i++) {
            int c = output % 10;
            output /= 10;

            result[idx + outLen - i] = 48 + c;
        }
        result[idx] = 48 + output % 10;
        result[++idx] = 46;

        idx += outLen;
        if(outLen == 1) {
            result[idx++] = 48;
        }

        result[idx++] = 101;
        if(expon < 0) {
            result[idx++] = 45;
            expon = -expon;
        }
        if(expon >= 10) {
            result[idx++] = 48 + expon / 10;
        }
        result[idx++] = 48 + expon % 10;
    } else {
        if(expon < 0) {
            result[idx++] = 48;
            result[idx++] = 47;
            for(int i = -1; i > expon; i--) {
                result[idx++] = 48;
            }

            int cur = idx;
            for(int i = 0; i < outLen; i++) {
                result[cur + outLen - i - 1] = 48 + output % 10;
                output /= 10;
                idx++;
            }
        } else if(expon + 1 >= outLen) {
            for(int i = 0; i < outLen; i++) {
                result[idx + outLen - i - 1] = 48 + output % 10;
                output /= 10;
            }
            idx += outLen;

            for(int i = outLen; i < expon + 1; i++) {
                result[idx++] = 48;
            }
            result[idx++] = 46;
            result[idx++] = 48;
        } else {
            int cur = idx + 1;
            for(int i = 0; i < outLen; i++) {
                if(outLen - i - 1 == expon) {
                    result[cur + outLen - i - 1] = 46;
                    cur--;
                }
                result[cur + outLen - i - 1] = 48 + output % 10;
                output /= 10;
            }
            idx += outLen + 1;
        }
    }

    str.len = idx;
    str.chars = (int*) malloc(idx * sizeof(int));
    
    memcpy(str.chars, result, idx * sizeof(int));
    free(result);

    return str;
}

struct utf8_string float2String(float num) {
    unsigned int bits = ((union {float f; unsigned int i;}) {num}).i;

    struct utf8_string str;
    if(num != num) {
        str.len = 3;
        str.chars = (int*) strNaN;
        return str;
    } else if(num == INFINITY) {
        str.len = 3;
        str.chars = (int*) strPosInf;
        return str;
    } else if(num == -INFINITY) {
        str.len = 4;
        str.chars = (int*) strNegInf;
        return str;
    } else if(num == 0) {
        int sign = bits >> 31;
        if(sign == 0) {
            str.len = 3;
            str.chars = (int*) strPosZero;
        } else {
            str.len = 4;
            str.chars = (int*) strNegZero;
        }
        return str;
    } else {
        return normalString(num, bits);
    }
}

// Demo
const int byteLead = 0x80;
const int byteMask = 0x3F;

const int byte2Lead = 0xC0;
const int byte3Lead = 0xE0;
const int byte4Lead = 0xF0;

const int byteMax = (1 << 7) - 1;
const int byte2Max = (1 << 11) - 1;
const int byte3Max = (1 << 16) - 1;

void printChar(int cp) {
    if(cp <= byteMax) {
        putchar(cp);
    } else if(cp <= byte2Max) {
        putchar(byte2Lead | cp >> 6);
        putchar(byteLead | cp & byteMask);
    } else if(cp <= byte3Max) {
        putchar(byte3Lead | cp >> 12);
        putchar(byteLead | cp >> 6 & byteMask);
        putchar(byteLead | cp & byteMask);
    } else {
        putchar(byte4Lead | cp >> 18);
        putchar(byteLead | cp >> 12 & byteMask);
        putchar(byteLead | cp >> 6 & byteMask);
        putchar(byteLead | cp & byteMask);
    }
}