#include <bits/stdc++.h>
using namespace std;
typedef long long int ll; 

ll minmax(vector <ll> A, ll N, ll k)
{
    ll high = 0;
    //find max element in vector
    ll low = 0;
    for(ll i=0;i<N;i++)
    {
        if(A[i]>low)
        {
            low = A[i];
        }
        high+=A[i]; //max sum is the sum of all elements in the array
    }

    ll ans = 0;

    while(low<=high)
    {
        //modified binary search
        ll possible = 1;
        ll mid = low + ((high - low)/2);
        ll steps = 0; //count the number of steps it would take reach number
        ll sum = 0;

        for(ll i=0;i<N;i++)
        {
            if(A[i] > mid) 
            {
                possible = 0;
                break;
            }

            sum += A[i]; 
            if(sum > mid)
            {
                steps++;
                sum = A[i];
            }
        }
        if(possible)
        {
            steps++;
            if(steps<=k)
            {
                possible = 1;
            }
            else{
                possible = 0;
            }
        }

        if(possible)
        {
            ans = mid;
            high = mid - 1;
        }
        else
        {
            low = mid + 1;
        }
    }

    return ans;
}

int main(){
    //the idea is to use binary search to find the min of the range and then eliminate one half of the array
    // we modify binary search to do our problem
    ll N,k;
    cin>>N;
    cin>>k;
    vector <ll> array(N);

    for(ll i=0;i<N;i++)
    {
        cin>>array[i];
    }
    ll ans = minmax(array,N,k);
    cout<<ans<<endl;
}