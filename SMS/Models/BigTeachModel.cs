using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMS.Models
{
    public class BigTeachModel
    {
        public int SysId { get; set; }
        public Nullable<int> YearId { get; set; }
        public Nullable<int> SectionId { get; set; }
        public Nullable<int> DepartmentId { get; set; }
        public Nullable<int> CourseId { get; set; }
        public Nullable<int> TeacherId { get; set; }

        public virtual Year Year { get; set; }
        public virtual Section Section { get; set; }
        public virtual Department Department { get; set; }
        public virtual Course Course { get; set; }
        public virtual Teacher Teacher { get; set; }
    }
}