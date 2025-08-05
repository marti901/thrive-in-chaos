using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateSlimBuilder(args);

builder.Services.AddHealthChecks();

var app = builder.Build();

app.MapHealthChecks("/health");
app.MapGet("/", ([FromServices] IConfiguration configuration) =>
	$"Response from: {configuration.GetValue<string>("ServiceName")}");

await app.RunAsync();
