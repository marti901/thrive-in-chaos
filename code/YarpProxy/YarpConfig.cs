using Yarp.ReverseProxy.Configuration;

namespace YarpProxy;

public static class YarpConfig
{
	private const string IdCluster0 = "cluster0";

	public static IReadOnlyList<RouteConfig> Routes =>
	[
		new RouteConfig
		{
			RouteId = "Route0",
			ClusterId = IdCluster0,
			Match = new RouteMatch
			{
				Path = "{**catch-all}",
			}
		}
	];

	public static IReadOnlyList<ClusterConfig> GetClusters(string urlServiceA, string urlServiceB) =>
	[
		new ClusterConfig
		{
			ClusterId = IdCluster0,
			Metadata = new Dictionary<string, string>()
			{
				{ "ConsecutiveFailuresHealthPolicy.Threshold", "1" }
			},
			HealthCheck = new HealthCheckConfig
			{
				Active = new ActiveHealthCheckConfig
				{
					Enabled = true,
					Interval = TimeSpan.FromSeconds(10),
					Timeout = TimeSpan.FromSeconds(10),
					Policy = "ConsecutiveFailures",
					Path = "/health"
				}
			},
			LoadBalancingPolicy = "FirstAlphabetical",
			Destinations = new Dictionary<string, DestinationConfig>()
			{
				{
					"service-a",
					new DestinationConfig
					{
						Address = urlServiceA,
						Health = urlServiceA,
					}
				},
				{
					"service-b",
					new DestinationConfig
					{
						Address = urlServiceB,
						Health = urlServiceB,
					}
				}
			}
		}
	];
}
