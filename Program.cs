using dao.Connection;
using Inmuebles.DTO;
using Inmuebles.Entities;
using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? throw new Exception("Connection string not found");

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddScoped(x => new MsSQLConnection(connectionString));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.MapGet("/inmueble", (MsSQLConnection connection) =>
{
    return connection.GetList<Inmueble>("dbo.SP_GETLIST_INMUEBLES", null);
})
.WithName("Root")
.WithOpenApi();

app.MapPost("/inmueble", ([FromBody] InmuebleDTO inmueble, MsSQLConnection connection) => {
    var parameters = new Dictionary<string, object>
    {
        { "direccion", inmueble.Direccion },
        { "cantHabitaciones", inmueble.CantidadHabitaciones },
        { "estadoInmueble", inmueble.EstadoInmueble },
        { "disponibilidad", inmueble.Disponibilidad },
        { "ciudad", inmueble.Ciudad },
        { "tipoInmuebleID", inmueble.TipoInmuebleID }
    };

    return connection.GetOne<Inmueble>("dbo.SP_INSERT_INMUEBLE", parameters);
})
.WithName("Root2")
.WithOpenApi();

app.MapPut("/inmueble/{id}", (int id, [FromBody] InmuebleDTO inmueble, MsSQLConnection connection) => {
    var parameters = new Dictionary<string, object>
    {
        { "idInmueble", id },
        { "direccion", inmueble.Direccion },
        { "cantHabitaciones", inmueble.CantidadHabitaciones },
        { "estadoInmueble", inmueble.EstadoInmueble },
        { "disponibilidad", inmueble.Disponibilidad },
        { "ciudad", inmueble.Ciudad },
        { "tipoInmuebleID", inmueble.TipoInmuebleID }
    };

    return connection.GetOne<Inmueble>("dbo.SP_UPDATE_INMUEBLE", parameters);
})
.WithName("Root3")
.WithOpenApi();

app.MapDelete("/inmueble/{id}", (int id, MsSQLConnection connection) => {
    var parameters = new Dictionary<string, object>
    {
        { "idInmueble", id }
    };

    return connection.Confirm("dbo.SP_DELETE_INMUEBLE", parameters);
})
.WithName("Root4")
.WithOpenApi();

app.Run();
