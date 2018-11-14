import java.util.Arrays;
import java.util.HashMap;
import java.util.Set;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

class pathtype
{
	public int[] pi;
	public int end;
}
class distpathdomi
{
	float[] dist;
	pathtype[] path;
	int[][] dominance;
}
class congoal
{
	float begin;
	float end;
	List<Integer> o;
}
class Dijkstra
{
	
	public distpathdomi dijkstra(float G[][],int v0,int vi,int vj,int n,int objbegin) 
	{
		System.out.println("----------------Dijkstra-----begin---------------");
		distpathdomi dpd = new distpathdomi();
		int[][] dominance=new int[n][n];
		int i;
		int j;
		int k;
		for (i=0;i<n ;i++ ) 
		{
			for (j=0;j<n ;j++) 
			{
				dominance[i][j]=0;	
			}
		}
		int count;
		int[] S = new int[n];
		float m; 
		int u=v0;
		int w;
		float[] dist = new float[n];
		pathtype[] path= new pathtype[n];
		for (i=0;i<n;i++)
		{
			
			pathtype pt=new pathtype();
			
			pt.pi=new int[n];
			pt.pi[0]=v0;
			pt.end=0;
			path[i]=pt;
			pt=null;
			
			S[i]=0;
			dist[i]=G[v0][i];
			
		}
		S[v0]=1;
		count=1;
		while(count<=n-1)
		{
			
			m=Float.MAX_VALUE;
			for (w=0;w<=n-1;w++) 
				if (S[w]==0&&dist[w]<m) 
				{
					u=w;
					m=dist[w];
				}
			if (m==Float.MAX_VALUE)
				break;
			S[u]=1;
			path[u].end++;
			path[u].pi[path[u].end]=u;
			for (w=0;w<=n-1 ;w++ ) 
				if (S[w]==0&&dist[w]>dist[u]+G[u][w]) 
				{
					dist[w]=dist[u]+G[u][w];
					for (i=0;i<n ; i++) 
					{
						path[w].pi[i]=path[u].pi[i];	
					}
					// path[w].pi=path[u].pi;	//very important , not  equals to  path[w]=path[u]  
					path[w].end=path[u].end;
					
				}
			count++;
			
		}
		for (i=objbegin;i<n ;i++ ) 
		{
			for (j=objbegin;j<n ;j++ ) 
			{
				int flag=0;
				int end =path[i].end;
				if (path[j].end>end) 
				{
					for (k=0;k<=end ;k++ )
					{
						if(path[i].pi[k]==path[j].pi[k])
							{flag=1;continue;}
						else
							{flag=0;break;}
					}	
				}
				if(flag==1)
				{
					dominance[i][j]++;
					dominance[j][i]--;
				}	
			}
		}
		dpd.dominance=dominance;
		dpd.dist=dist;
		dpd.path=path;
		System.out.println("----------------Dijkstra-----end---------------");
		return dpd;
	}
}
class snapshot
{
	public List<Map.Entry<Integer,Integer>> snapshot(float[][] G,int v0,int vi,int vj,int n,int objbegin)
	{
		System.out.println("----------------snapshot-----begin---------------");
		int i;int j;int k;
		Map objdomi = new TreeMap();
		distpathdomi dpd;
		Dijkstra d = new Dijkstra();

		dpd=d.dijkstra(G,v0,vi,vj,n,objbegin);
		System.out.print("\nthe distance between beginvertex--"+v0 +"--and every vertex  is :");
		for (i=0;i<n ;i++ ) 
		{
			System.out.print("--"+dpd.dist[i]+"--");
		}
		for(i=0;i<n;i++)
		{
			System.out.print("\nthe path between beginvertex--"+v0 +"--and  vertex "+i+" is :");
			for ( j=0; j<=dpd.path[i].end;j++ ) 
			{
				System.out.print("--"+dpd.path[i].pi[j]+"--");
			}
			System.out.println("\n");
		}
		System.out.println("dominance :");
		for(i=objbegin;i<n;i++)
		{
			for(j=objbegin;j<n;j++)
			{
				System.out.print("   "+dpd.dominance[i][j]);
			}
			System.out.print("\n");
		}
		System.out.print("OBJ is:");
		for(i=objbegin;i<n;i++)
		{
			int flag=0;
			int domi=0;
			for(j=objbegin;j<n;j++)
			{
				if (dpd.dominance[i][j]>=0) 
				{
					flag=1;
					domi+=dpd.dominance[i][j];
				}
				else
				{
					flag=0;break;
				}
			}
			if(flag==1)
				{
					System.out.print("--"+i);
					try
					{
						objdomi.put(i,domi);
					}
					catch(Exception e)
					{
						e.printStackTrace();
					}
					System.out.println(objdomi);

				}
				
		}
		//这里将map.entrySet()转换成list
        List<Map.Entry<Integer,Integer>> list = new ArrayList<Map.Entry<Integer,Integer>>(objdomi.entrySet());
        //然后通过比较器来实现排序
        Collections.sort(list,new Comparator<Map.Entry<Integer,Integer>>() {
            //升序排序
            public int compare(Entry<Integer,Integer> o1,
                    Entry<Integer,Integer> o2) {
                return o2.getValue().compareTo(o1.getValue());
            }
            
        });
        System.out.println("\nsorted obj and dominator is :");
        for(Map.Entry<Integer,Integer> mapping:list){ 
               System.out.println(mapping.getKey()+":"+mapping.getValue()); 
          } 
        System.out.println("----------------snapshot-----end---------------");
        return list;
	}
}
class continuous
{
	public List<congoal> continuous(float[][] G,int v0,int vi,int vj,int n,int objbegin)
	{
		System.out.println("----------------continuous-----begin---------------");
		int i;int j;int k;
		float length=G[v0][vi]+G[v0][vj];
		float[][] G2=new float[n][n];
		float[][] G3=new float[n][n];
		float[][] G4=new float[n][n];
		List<Map.Entry<Integer,Integer>> list1;
		List<Map.Entry<Integer,Integer>> list2;
		List<Float> dcp = new ArrayList<Float>();//direction change point
		dcp.add(0f);dcp.add(length);
		List<Integer> obj1 = new ArrayList<Integer>();
		List<Integer> obj2 = new ArrayList<Integer>();
		List<Integer> obj3 = new ArrayList<Integer>();
		List<Integer> obj4 = new ArrayList<Integer>();
		List<Integer> obj5 = new ArrayList<Integer>();
		distpathdomi dpd1;
		distpathdomi dpd2;
		Dijkstra d = new Dijkstra();
		dpd1=d.dijkstra(G,vi,vi,vj,n,objbegin);
		dpd2=d.dijkstra(G,vj,vi,vj,n,objbegin);
		for(i=0;i<n;i++)
		{
			for(j=0;j<n;j++)
			{
				G2[i][j]=G[i][j];
				G3[i][j]=G[i][j];
				G4[i][j]=G[i][j];
			}
		}
		G2[v0][vi]=0;G2[v0][vj]=length;
		G3[v0][vi]=length;G2[v0][vj]=0;
		snapshot s = new snapshot();
		list1=s.snapshot(G2,v0,vi,vj,n,objbegin);//for vi 
		System.out.println("list1");
		for(Map.Entry<Integer,Integer> mapping:list1){ 
               System.out.println(mapping.getKey()+":"+mapping.getValue()); 
               obj1.add(mapping.getKey());
               obj3.add(mapping.getKey());
               obj4.add(mapping.getKey());//keep unchanged  

          } 
		list2=s.snapshot(G3,v0,vi,vj,n,objbegin);//for vj
		System.out.println("list2");
		for(Map.Entry<Integer,Integer> mapping:list2){ 
               System.out.println(mapping.getKey()+":"+mapping.getValue()); 
               obj2.add(mapping.getKey());
               obj5.add(mapping.getKey());//keep unchanged
          } 
		obj1.retainAll(obj2);//obj1 is jiaoji
		obj2.removeAll(obj3);
		obj3.addAll(obj2);//obj3 is bingji
		obj3.removeAll(obj1);//obj3 is bingji - jiaoji
		System.out.println("jiaoji ");
		for(Integer O:obj1)
		{ 
               System.out.println(O); 
        } 
        System.out.println("bingji -jiaoji ");
		for(Integer O:obj3)
		{ 
               System.out.println(O); 
        } 

		for(i=objbegin;i<n;i++)
		{
			if(obj3.contains(i))
			{
				dcp.add((length+dpd2.dist[i]-dpd1.dist[i])/2);
				System.out.println("dcp["+i+"]:"+dcp); 
			}
			
		}
		Collections.sort(dcp);
		System.out.println(dcp);
		List<congoal> goal=new ArrayList<congoal>();
		List<Map.Entry<Integer,Integer>> list;
		for(i=0;i<dcp.size()-1;i++)
		{
			congoal go=new congoal();
			go.begin=dcp.get(i);
			go.end=dcp.get(i+1);
			go.o=new ArrayList<Integer>();
			int vmid=(int)((go.begin+go.end)/2);
			G4[v0][vi]=vmid;G4[v0][vj]=length-vmid;
			list=s.snapshot(G4,v0,vi,vj,n,objbegin);
			for(Map.Entry<Integer,Integer> mapping:list)
			{
				go.o.add(mapping.getKey());
				//System.out.println("go.o"+go.o);
			}
			goal.add(go);
		}
		for(congoal cg:goal)
		{
			System.out.println("qujian("+cg.begin+","+cg.end+"):"+cg.o);
		}
		System.out.println("----------------continuous-----end---------------");
		return goal;
	}
	
}
class reverse
{
	public void reverse(float[][] G,int n,int userend,int objbegin)
	{
		System.out.println("----------------reverse-----begin---------------");
		int i;int j;int k;int vi=0;int vj=0;
		int[][] reve=new int[userend+1][n];
		for(i=0;i<=userend;i++)
		{
			for(j=0;j<n;j++)
			{
				reve[i][j]=0;
			}
		}
		snapshot s = new snapshot();
		for(i=0;i<=userend;i++)
		{
			List<Map.Entry<Integer,Integer>> list;
			System.out.println("----------------i="+i+"-----begin---------------");
			list=s.snapshot(G,i,vi,vj,n,objbegin);
			for(Map.Entry<Integer,Integer> mapping:list)
			{ 
               reve[i][mapping.getKey()]=1;
          	} 
          	System.out.println("----------------i="+i+"-----end---------------");
		}
		for(i=0;i<=userend;i++)
		{
			for(j=0;j<n;j++)
			{
				System.out.print("  "+reve[i][j]);
			}
			System.out.println("\n");
		}
		for(i=objbegin;i<n;i++)
		{
			System.out.print("the reverse of "+i+"  is:");
			for(j=0;j<=userend;j++)
			{
				if(reve[j][i]==1)
					System.out.print("--"+j);
			}
			System.out.print("\n"); 
		}
		System.out.println("----------------reverse-----end---------------");
	}
}
public class testD
{
	public static void main(String[] args) 
	{
		float M=Float.MAX_VALUE;
		// float G[][]=
		// {
		// 	{0,M,M,M,3,M,3,M,M,M,M},
		// 	{M,0,9,M,M,M,M,M,M,M,4},
		// 	{M,9,0,M,M,M,M,M,2,M,M},
		// 	{M,M,M,0,M,M,4,2,M,3,M},
		// 	{3,M,M,M,0,3,M,M,M,2,M},
		// 	{M,M,M,M,3,0,5,M,M,M,3},
		// 	{3,M,7,4,M,5,0,M,M,M,M},
		// 	{M,M,M,2,M,M,M,0,1,M,M},
		// 	{M,M,2,M,M,M,M,1,0,M,M},
		// 	{M,M,M,3,2,M,M,M,M,0,M},
		// 	{M,4,M,M,M,3,M,M,M,M,0}
		// };
		float G[][]=
		{
			{0,M,M,M,M,M,M,M,M,M,3,M,3,M,M,M,M},
			{M,0,M,M,M,M,M,M,M,2,M,M,2,M,M,M,M},
			{M,M,0,M,M,M,M,M,4,M,M,M,3,M,M,M,M},
			{M,M,M,0,M,M,M,5,4,M,M,M,M,M,M,M,M},
			{M,M,M,M,0,M,M,2,M,M,M,M,M,M,M,M,2},
			{M,M,M,M,M,0,M,M,M,M,1,2,M,M,M,M,M},
			{M,M,M,M,M,M,0,M,M,1,M,M,M,M,M,2,M},
			{M,M,M,5,2,M,M,0,M,M,M,M,M,M,M,M,M},
			{M,M,4,4,M,M,M,M,0,M,M,M,M,M,2,M,M},
			{M,2,M,M,M,M,1,M,M,0,M,M,M,2,M,M,M},
			{3,M,M,M,M,1,M,M,M,M,0,M,M,M,M,2,M},
			{M,M,M,M,M,2,M,M,M,M,M,0,5,M,M,M,3},
			{3,2,3,M,M,M,M,M,M,M,M,5,0,M,M,M,M},
			{M,M,M,M,M,M,M,M,M,2,M,M,M,0,1,M,M},
			{M,M,M,M,M,M,M,M,2,M,M,M,M,1,0,M,M},
			{M,M,M,M,M,M,2,M,M,M,2,M,M,M,M,0,M},
			{M,M,M,M,2,M,M,M,M,M,M,3,M,M,M,M,0},
		};
		// float G3[][]=
		// {
		// 	{0,M,M,M,0,M,6,M,M,M,M},
		// 	{M,0,9,M,M,M,M,M,M,M,4},
		// 	{M,9,0,M,M,M,M,M,2,M,M},
		// 	{M,M,M,0,M,M,4,2,M,3,M},
		// 	{3,M,M,M,0,3,M,M,M,2,M},
		// 	{M,M,M,M,3,0,5,M,M,M,3},
		// 	{3,M,7,4,M,5,0,M,M,M,M},
		// 	{M,M,M,2,M,M,M,0,1,M,M},
		// 	{M,M,2,M,M,M,M,1,0,M,M},
		// 	{M,M,M,3,2,M,M,M,M,0,M},
		// 	{M,4,M,M,M,3,M,M,M,M,0}
		// };
		// float G[][]=
		// {
		// 	{0,20,15,M,M,M},
		// 	{20,0,M,2,10,30},
		// 	{15,M,0,2,M,10},
		// 	{M,2,2,0,M,M},
		// 	{M,10,M,M,0,10},
		// 	{M,30,10,M,10,0}
		// };
		// float G[][]=
		// {
		// 	{0,20,15,M,M,M},
		// 	{2,0,4,M,10,30},
		// 	{M,M,0,M,M,10},
		// 	{M,M,M,0,M,M},
		// 	{M,M,M,15,0,10},
		// 	{M,M,M,4,M,0}
		// };
		// int v0=0;
		// int n=11;
		// int vi=6;
		// int vj=4;
		// int objbegin=7;
		int v0=0;
		int n=17;
		int vi=12;
		int vj=9;
		int objbegin=13;
		int userend=6;
		List<congoal> goal;
		snapshot s = new snapshot();
		s.snapshot(G,v0,vi,vj,n,objbegin);
		continuous c = new continuous();
		goal=c.continuous(G,v0,vi,vj,n,objbegin);
		reverse r=new reverse();
		r.reverse(G,n,userend,objbegin);
	}
}