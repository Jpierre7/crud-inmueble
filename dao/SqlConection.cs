using System.Data;
using System.Text;
using System.Text.Json;
using Microsoft.Data.SqlClient;

namespace dao.Connection;

public class MsSQLConnection
{
    private readonly string _connectionString;

    public MsSQLConnection(string connectionString)
    {
        _connectionString = connectionString;
    }

    public async Task<ICollection<T>> GetList<T>(string storedProcedure, Dictionary<string, object> parameters)
    {
        using var connection = new SqlConnection(_connectionString);
        await connection.OpenAsync();
        var result = new List<T>();
        using var command = connection.CreateCommand();

        command.CommandText = storedProcedure;
        command.CommandType = CommandType.StoredProcedure;
        AddParameters(command, parameters);

        using SqlDataReader reader = await command.ExecuteReaderAsync();
        var response = new StringBuilder();

        while (reader.Read())
        {
            if (!reader.IsDBNull(0))
                response.Append(reader.GetString(0));
        }

        var str = response.ToString();
        return str == "" ? new List<T>() : JsonSerializer.Deserialize<List<T>>(str, new JsonSerializerOptions { PropertyNameCaseInsensitive = true });
    }

    public async Task<T> GetOne<T>(string storedProcedure, Dictionary<string, object> parameters) where T : class
    {
        using var connection = new SqlConnection(_connectionString);
        await connection.OpenAsync();
        using var command = connection.CreateCommand();

        command.CommandText = storedProcedure;
        command.CommandType = CommandType.StoredProcedure;
        AddParameters(command, parameters);

        SqlDataReader reader = await command.ExecuteReaderAsync();
        var response = new StringBuilder();

        while (reader.Read())
        {
            if (!reader.IsDBNull(0))
                response.Append(reader.GetString(0));
        }

        var str = response.ToString();
        return str == "" ? null : JsonSerializer.Deserialize<T>(str, new JsonSerializerOptions { PropertyNameCaseInsensitive = true });
    }

    public async Task<bool> Confirm(string storedProcedure, Dictionary<string, object> parameters)
    {
        using var connection = new SqlConnection(_connectionString);
        await connection.OpenAsync();
        using var command = connection.CreateCommand();

        command.CommandText = storedProcedure;
        command.CommandType = CommandType.StoredProcedure;
        AddParameters(command, parameters);

        int reader = await command.ExecuteNonQueryAsync();

        return reader > 0;
    }

    private void AddParameters(SqlCommand command, Dictionary<string, object> parameters)
    {
        if (parameters != null)
        {
            foreach (KeyValuePair<string, object> parametro in parameters)
            {
                SqlParameter sqlPar = new SqlParameter("@" + parametro.Key, parametro.Value)
                {
                    Direction = ParameterDirection.Input
                };
                command.Parameters.Add(sqlPar);
            }
        }
    }
}
