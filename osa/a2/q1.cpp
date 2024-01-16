#include <bits/stdc++.h>
using namespace std;

int possibilities(vector<int> &T, int n, int index,int sum, int total, vector<vector<int> > &dp)
{
    //here sum is the sum of numbers we are including in the subset while total is the total sum of numbers
    if (index == n)
    {
       //all elements have either been included or excluded so we find max sum of two subsets
       return max(total - sum,sum);
    }

    if(dp[index][sum] != -1)
    {
        //already computed
        return dp[index][sum];
    }

    //either include or exclude the element from the subset
    int include = possibilities(T,n,index+1,sum+T[index],total,dp);
    int exclude = possibilities(T,n,index+1,sum,total,dp);

    //store in dp table
    return dp[index][sum] = min(include,exclude);
}

int minTime(vector<int> T, int n)
{
    int sum = 0;
    for (int i = 0; i < n; i++)
    {
        sum += T[i];
    }

    vector<vector <int> > dp(n + 1, vector<int>(sum,-1)); //make a dp 2d array to store combinations that have been computed
    return possibilities(T,n,0,0,sum,dp);
}

int main()
{
    int N;
    cin >> N;

    vector<int> T(N);
    for (int i = 0; i < N; i++)
    {
        cin >> T[i];
    }
    int ans = minTime(T, N);
    cout << ans << endl;
}