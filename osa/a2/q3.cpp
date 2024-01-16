#include <bits/stdc++.h>
using namespace std;

long long int beautiful(vector<long long int> &A, int N)
{
    long long int ans = 0;
    vector<vector<long long int> > dp(N+2,vector<long long int> (N+1,0)); //dp array to store values - memoization

    vector <long long int> prefix(N+1,0);
    long long int count=0;
    
    prefix[0] = A[0];
    for(long long int i=1;i<N;i++)
    {
        prefix[i]= (prefix[i-1] + A[i]); //we do not modulo here so that we can check divisibility properly
    }

    dp[1][0] = 1; //base case -> because first prefix sum is 0 so trivially divisible by 0
    for(long long int i=0;i<N;i++)
    {
        for(long long int j=N;j>=1;j--)
        {
            count = (prefix[i] % (j+1)) %1000000007; // checking if the sum of subarray till i is divisible by j+1
            dp[j+1][count] = (dp[j+1][count] +  dp[j][(prefix[i]%(j))%1000000007])%1000000007;

            if(i==(N-1)) //this is when all the elements of the array are being considered which is our answer
            {
                ans = (ans + dp[j][prefix[i]%j])%1000000007;
            }
        }
    }

    return ans;
}

int main()
{
    int N;
    cin>>N;

    vector<long long int> A(N);
    for(int i=0;i<N;i++)
    {
        cin>>A[i];
    }

    long long int ans = beautiful(A,N);
    cout<<ans<<endl;
}