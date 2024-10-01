namespace Inmuebles.Entities;

public class TipoInmueble
{
    public int TipoInmuebleID { get; set; }
    public string Descripcion { get; set; }
    public DateTime FechaCreacion  { get; set; }

    public TipoInmueble(int tipoInmuebleID, string descripcion, DateTime fechaCreacion)
    {
        TipoInmuebleID = tipoInmuebleID;
        Descripcion = descripcion;
        FechaCreacion = fechaCreacion;
    }
}