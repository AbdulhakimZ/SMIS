using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SMS.Models
{
    public class ChangePasswordModel
    {
        public int SysId { get; set; }
        public string Previous { get; set; }
        [Required]
        [StringLength(20,ErrorMessage ="Password cannot be lessthan 6 charachters", MinimumLength = 6)]
        public string NewPassword { get; set; }
        [Required]
        [StringLength(20,ErrorMessage ="Password cannot be lessthan 6 charachters", MinimumLength = 6)]
        public string Confirm { get; set; }
        public string Role { get; set; }
    }
}