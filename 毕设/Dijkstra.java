public class Dijkstra
{
	
	int n=6;
	//initialize path to maximum
	int path[][]=new int[n+1][n+1];
	void initpath()
	{
		for(int i=1;i<n+1;i++)
			for(int j=1;j<n+1;j++)
				path[i][j]=Integer.MAX_VALUE;
	}
	//input  the detail of  path[i][j],
	//if there is duplication,then update the path to minmum
	int minLen[]=new int[n+1];
	//visit   init set as 0，Prevent back
	int visit[]=new int[n+1];
	//init the distance between 1 and other point.
	void initminlen()
	{
		for(int i=1;i<n+1;i++)
		{
			minLen[i]=path[1][i];
		}
	}
		
	
	void Dijkstra()
	{
		minLen[1]=0;
		visit[1]=1;
		int minj=1;
		for(int i=1;i<n+1;i++)
		{
			int min=Integer.MAX_VALUE;
			for(int j=1;j<n+1;j++)
			{
				if(visit[j]==0&&minLen[j]<min)
				{
					min=minLen[j];
					minj=j;
				}
			}
			visit[minj]=1;
			for(int j=1;j<n+1;j++)
			{
				if(visit[j]==0&&minLen[minj]!=Integer.MAX_VALUE&&path[minj][j]!=
				Integer.MAX_VALUE&&minLen[j]>(minLen[minj]+path[minj][j]))
				{
					minLen[j]=minLen[minj]+path[minj][j];
				}
			}
		}
	}
	public static void main(String[] args) 
	{
		System.out.print("Hello World");
	}
}