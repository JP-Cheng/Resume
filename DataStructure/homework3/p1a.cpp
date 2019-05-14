#include <iostream>

using namespace std;

int catalanRecursive(int n)
{
    if (n <= 0)
        return 0;
    else if (n == 1)
        return 1;
    else
        return 2 * (2 * n - 1) * catalanRecursive(n - 1) / (n + 1);
}

/*
int catalanDef(int n)
{
    if (n <= 0)
        return 0;
    else if (n == 1 || n == 2)
        return 1;
    else
        return ();
}
*/

int main()
{
    int n = 0;
    cin >> n;
    cout << catalanRecursive(n) << endl;
    return 0;
}