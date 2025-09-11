using System.Threading.RateLimiting;
using Microsoft.AspNetCore.RateLimiting;
using Microsoft.EntityFrameworkCore;
using Scalar.AspNetCore;
using Sprint3_API;
using Sprint3_API.Endpoints;
using Sprint3_API.Services;

var builder = WebApplication.CreateBuilder(args);

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

// define um limite de requisições durante um determinado período.
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

builder.Services.AddOpenApi();

// trigga uma exceção caso haja uma.
builder.Services.AddDatabaseDeveloperPageExceptionFilter();

// adiciona o CORS na aplicação
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

//  habilita o CORS
app.UseCors();
// limita a qtnd de requisições
app.UseRateLimiter();

app.MapHub<SetorHub>("/hub/setores");

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.MapScalarApiReference();
}

app.MapOpenApi();
app.MapScalarApiReference();

// endpoints de Cliente
app.MapClienteEndpoints();

// endpoints de Moto
app.MapMotoEndpoints();

// endpoints de Pátio
app.MapPatioEndpoints();

// endpoints de Cargo
app.MapCargoEndpoints();

// endpoints de Funcionário
app.MapFuncionarioEndpoints();

// endpoints de Gerente
app.MapGerenteEndpoints();

// endpoints de Vaga
app.MapVagaEndpoints();

// endpoints de Setor
app.MapSetorEndpoints();

// endpoints de Movimentação
app.MapMovimentacaoEndpoints();

await app.RunAsync();