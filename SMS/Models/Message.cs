//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SMS.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Message
    {
        public int SysId { get; set; }
        public string From { get; set; }
        public Nullable<int> ToStudents { get; set; }
        public Nullable<int> ToTeachers { get; set; }
        public string Subject { get; set; }
        public string Body { get; set; }
        public Nullable<int> Status { get; set; }
        public Nullable<System.DateTime> SentDate { get; set; }
        public Nullable<int> IsDeleted { get; set; }
    
        public virtual Student Student { get; set; }
        public virtual Teacher Teacher { get; set; }
    }
}
