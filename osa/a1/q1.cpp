
#include <bits/stdc++.h>
using namespace std;

typedef long long int ll;

ll gpTerm(ll k, ll n)
{
    ll ans=1;
    ll temp;

    if(n==1)
    {
        return k%(1000000007);
    }
    else if(n<=0)
    {
        return ans%(1000000007);
    }

    if(n%2)
    {
        temp = gpTerm(k,n/2);
        ans = (temp*temp)%(1000000007);
        ans = (ans*k)%(1000000007);
        return ans;
    }
    else
    {
        temp = gpTerm(k,n/2);
        return (temp*temp)%(1000000007);
    }

    return ans;
}

int main(){
    ll T, k, n;
    cin>>T;

    for(ll i=0;i<T;i++)
    {
        cin>>k;
        cin>>n;
        // cout<<k<<" "<<n<<endl;
        ll a = gpTerm(k,n-1);
        cout<<a<<endl;
    }
}