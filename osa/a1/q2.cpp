#include <bits/stdc++.h>
using namespace std;

int minmax(vector <int> A, int N, int k)
{
    int low = 0;
    //find max element in vector
    int high = 0;
    for(int i=0;i<N;i++)
    {
        if(A[i]>high)
        {
            high = A[i];
        }
    }

    while(low<high)
    {
        //modified binary search
        int possible = 0;
        int mid = low + ((high - low)/2);
        int steps = 0; //count the number of steps it would take reach number

        if(mid == 0)
        {
            return high;
        }
        for(int i=0;i<N;i++)
        {
            steps += (A[i])/mid;
        }

        if(steps <= k) possible = 1;

        if(possible) high = mid; //search for a lower max in the first half
        else low = mid + 1; //search for a max in the second half
    }

    return high;
}

int main(){
    //the idea is to use binary search to find the min of the range and then eliminate one half of the array
    // we modify binary search to do our problem
    int N,k;
    cin>>N;
    cin>>k;
    vector <int> buckets(N);

    for(int i=0;i<N;i++)
    {
        cin>>buckets[i];
    }
    int ans = minmax(buckets,N,k);
    cout<<ans<<endl;
}