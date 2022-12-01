// Bellman Ford Algorithm in C++

#include <bits/stdc++.h>
using namespace std;

// v: number of vertices
// S : source vertex
vector<int> bellman_ford(int v, vector<vector<int>>&edges, int S)
{
    vector<int> dist(v, 1e9);
    dist[S] = 0;
    for(int i=0;i<edges.size()-1;i++)
    {
        for(auto it:edges)
        {
            int from = it[0];
            int to = it[1];
            int weight = it[2];
            
            if (dist[from]!=1e9 && (dist[from] + weight < dist[to]))
            {
                dist[to] = dist[from] + weight;
            }
        }
    }
    return dist;
}

void addEdge(vector<vector<int>> &edges, int from, int to, int weight)
{
    vector<int> temp;
    temp.push_back(from);
    temp.push_back(to);
    temp.push_back(weight);
    edges.push_back(temp);
}

int main(){
    int v = 5;
    vector<vector<int>> adj;
    addEdge(adj, 0, 1, 10);
    addEdge(adj, 0, 4, 20);
    addEdge(adj, 1, 2, 30);
    addEdge(adj, 1, 3, 40);
    addEdge(adj, 1, 4, 50);
    addEdge(adj, 2, 3, 60);
    addEdge(adj, 3, 4, 70);
    
    vector<int> dist = bellman_ford(v, adj, 0);
    for(auto x:dist)
    {
        cout<<x<<" ";
    }
    return 0;
}
