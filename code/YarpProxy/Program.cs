using YarpProxy;
using YarpProxy.Exceptions;

var builder = WebApplication.CreateBuilder(args);

string urlServiceA = builder.Configuration.GetValue<string>("UrlServiceA") ??
	throw new ConfigurationException("Missing configuration setting 'UrlServiceA'!");

string urlServiceB = builder.Configuration.GetValue<string>("UrlServiceB") ??
	throw new ConfigurationException("Missing configuration setting 'UrlServiceB'!");

builder.Services
	.AddReverseProxy()
	.LoadFromMemory(YarpConfig.Routes, YarpConfig.GetClusters(urlServiceA, urlServiceB));

var app = builder.Build();

app.MapReverseProxy();

app.Run();
