using System.Text.Json;
using System.Threading.RateLimiting;
using Asp.Versioning;
using DotNetEnv;
using Microsoft.AspNetCore.RateLimiting;
using Microsoft.EntityFrameworkCore;
using Scalar.AspNetCore;
using Sprint3_API;
using Sprint3_API.Endpoints;
using Sprint3_API.Services;

using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.Filters;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "API Mottu Mottion",
        Version = "v1",
        Description = "Uma API para gerenciamento dos pátios da Mottu"
    });

    options.ExampleFilters();
});

builder.Services.AddSwaggerExamplesFromAssemblyOf<Program>();

builder.Services.AddDbContext<AppDbContext>(options => 
    options.UseNpgsql(builder.Configuration.GetConnectionString("PostgreConnection")));

builder.Services.AddScoped<ClienteService>();
builder.Services.AddScoped<MotoService>();
builder.Services.AddScoped<PatioService>();
builder.Services.AddScoped<CargoService>();
builder.Services.AddScoped<FuncionarioService>();
builder.Services.AddScoped<GerenteService>();
builder.Services.AddScoped<VagaService>();
builder.Services.AddScoped<SetorService>();
builder.Services.AddScoped<MovimentacaoService>();

builder.Services.AddRateLimiter(options =>
{
    options.AddFixedWindowLimiter("fixed", opt =>
    {
        opt.PermitLimit = 5;
        opt.Window = TimeSpan.FromSeconds(10);
        opt.QueueProcessingOrder = QueueProcessingOrder.OldestFirst;
        opt.QueueLimit = 2;
    });
});

builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(opt =>
    {
        opt.AllowAnyOrigin();
        opt.AllowAnyMethod();
        opt.AllowAnyHeader();
        opt.WithExposedHeaders("Content-Type", "Accept");
    });
});

builder.Services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
});

builder.Services.AddSignalR();

var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();

    var retries = 10;
    while (retries > 0)
    {
        try
        {
            db.Database.Migrate();
            break;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Banco ainda não está pronto... Tentando novamente. Erro: {ex.Message}");
            retries--;
            Thread.Sleep(5000);
        }
    }
}

app.UseCors();

app.UseRateLimiter();

app.MapHub<SetorHub>("/hub/setores");

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/swagger/v1/swagger.json", "API Mottu Mottion v1");
    });
}

app.UseSwagger();
app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/swagger/v1/swagger.json", "API Mottu Mottion v1");
    });

var apiVersionSet = app.NewApiVersionSet()
    .HasApiVersion(new ApiVersion(1))
    .Build();

app.MapClienteEndpoints();
app.MapMotoEndpoints();
app.MapPatioEndpoints();
app.MapCargoEndpoints();
app.MapFuncionarioEndpoints();
app.MapGerenteEndpoints();
app.MapVagaEndpoints();
app.MapSetorEndpoints();
app.MapMovimentacaoEndpoints();

await app.RunAsync();
