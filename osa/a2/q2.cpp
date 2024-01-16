#include <bits/stdc++.h>
using namespace std;

int maxGames(vector<int> &prices, vector<int> &valueg, int n, int budget)
{
    vector<vector<int> > dp(n+1,vector<int> (budget+1,0)); //array to store max games we could get if we had a certain budget

    for(int i=1;i<n+1;i++)
    {
        for(int j=1;j<budget+1;j++)
        {
            //check if our budget allows us to buy the item
            if(prices[i-1] <= j)
            {
                dp[i][j] = max(dp[i-1][j],valueg[i-1]+dp[i-1][j - prices[i-1]]); //store the max of including the gamehub or not including it
            }
            else
            {
                dp[i][j] = dp[i-1][j]; //if above budget then don't include gamehub
            }
        }
    }

    return dp[n][budget];
}

int main()
{
    int N,budget;
    cin >> N;
    cin>>budget;

    vector<int> prices(N);
    for (int i = 0; i < N; i++)
    {
        cin >> prices[i];
    }

    vector<int> valueg(N);
    for (int i = 0; i < N; i++)
    {
        cin >> valueg[i];
    }
    int ans = maxGames(prices,valueg,N,budget);
    cout << ans << endl;
}