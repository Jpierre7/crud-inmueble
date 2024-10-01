namespace Inmuebles.DTO;

public class InmuebleDTO
{
    public string Direccion { get; set; }
    public int CantidadHabitaciones { get; set; }
    public string EstadoInmueble { get; set; }
    public string Disponibilidad { get; set; }
    public string Ciudad { get; set; }
    public int TipoInmuebleID { get; set; }

    public InmuebleDTO(string direccion, int cantidadHabitaciones, string estadoInmueble, string disponibilidad, string ciudad, int tipoInmuebleID)
    {
        Direccion = direccion;
        CantidadHabitaciones = cantidadHabitaciones;
        EstadoInmueble = estadoInmueble;
        Disponibilidad = disponibilidad;
        Ciudad = ciudad;
        TipoInmuebleID = tipoInmuebleID;
    }
}
