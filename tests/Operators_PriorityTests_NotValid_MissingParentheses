program
{
    int num;
    double real;

    // (int)(true == !(num == 1 & 1 == num != 1 | 0 | 1 | ~2));
    // (int)(true == !(num == 1 & 1 == num != 1 | 0 | 1 |  x));
    // (int)(true == !(num == 1 == (num != x)));
    // (int)(true == !(false == num != x)
    // BAM : false == num, should be (false == (num != x))
    real = real = num = (int)(true == !(num == 1 & 1 == num != 1 | 0 | 1 | ~2));
}