using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capacitacion4B_api.Data
{
    public class PostgreSqlConnection
    {
        private string _connection;

        public PostgreSqlConnection(string connection)=> this._connection = connection;
    }
}
