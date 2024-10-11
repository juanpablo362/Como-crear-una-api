using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capacitacion4B_api.DTOs.User
{
    public class CreateUserDTO
    {
        public string? Names { get; set; }
        public string? UserName { get; set; }
        public string? Password { get; set; } 
    }
}
