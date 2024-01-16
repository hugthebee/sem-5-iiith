#include <bits/stdc++.h>
using namespace std;

typedef long long int ll;

ll mergeHalves(vector<ll>&X2,ll s, ll e, ll mid, vector<ll> &temp)
{
    //similar to merge in merge sort but with count functionality
    ll i = s;
    ll j = mid + 1;
    ll k = s;
    ll count = 0;

    while((i <= mid) && (j<=e))
    {
        if(X2[i] <= X2[j])
        {
            temp[k] = X2[i];
            i++;
            k++;
        }
        else
        {
            temp[k] = X2[j];
            k++;
            j++;

            count+= (mid - i + 1); //because if it is not sorted till here then there will be that many inversions
        }
    }

    while(i<=(mid))
    {
        //if there are remaining elemenets we just add them as is
        temp[k] = X2[i];
        i++;
        k++;
    }

    while(j<=e)
    {
        //if there are remaining elemenets we just add them as is
        temp[k] = X2[j];
        j++;
        k++;
    }

    for(int p = s; p<=e;p++)
    {
        X2[p] = temp[p];
    }

    return count;

}

ll intersections(vector<ll >& X2, ll s, ll e, vector<ll> &temp)
{
    //modified mergesort
    ll count = 0;
    if(s<e)
    {
        ll mid = s + ((e-s)/2);
        count += intersections(X2,s,mid,temp);
        count += intersections(X2,mid+1,e,temp);
        count += mergeHalves(X2,s,e,mid,temp);
    }

    return count;
}


int main()
{
    ll N;
    cin>>N;
    vector<pair <ll,ll> > points(N);
    vector <ll> X1(N);
    vector <ll> X2(N);
    vector <ll> temp(N); //to store sorted and merged array

    for(int i=0;i<N;i++)
    {
        cin>>X1[i];
        points[i].first = X1[i];
    }
    for(int i=0;i<N;i++)
    {
        cin>>X2[i];
        points[i].second = X2[i];
    }

    sort(points.begin(),points.end());
    //now the points are sorted based on the first vector points
    //this means it becomes a counting inversions problem
    for(int i=0;i<N;i++)
    {
        X2[i] = points[i].second;
    }
    ll ans = intersections(X2,0,N-1,temp);
    cout<<ans<<endl;
}