namespace Inmuebles.Entities;

public class Inmueble
{
    public int InmuebleID { get; set; }
    public string Direccion { get; set; }
    public int CantidadHabitaciones { get; set; }
    public string EstadoInmueble { get; set; }
    public string Disponibilidad { get; set; }
    public string Ciudad { get; set; }
    public DateTime FechaCreacion { get; set; }

    public Inmueble(int inmuebleID, string direccion, int cantidadHabitaciones, string estadoInmueble, string disponibilidad, string ciudad, DateTime fechaCreacion)
    {
        InmuebleID = inmuebleID;
        Direccion = direccion;
        CantidadHabitaciones = cantidadHabitaciones;
        EstadoInmueble = estadoInmueble;
        Disponibilidad = disponibilidad;
        Ciudad = ciudad;
        FechaCreacion = fechaCreacion;
    }
}