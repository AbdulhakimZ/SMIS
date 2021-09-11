using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMS.Models
{
    public class AssesmentAttachmentsModel
    {
        public int SysId { get; set; }
        public string Id { get; set; }
        public Nullable<int> Type { get; set; }
        public Nullable<System.TimeSpan> Time { get; set; }
        public Nullable<System.DateTime> GivenDate { get; set; }
        public Nullable<System.DateTime> DeadLine { get; set; }
        public Nullable<int> SectionID { get; set; }
        public Nullable<int> DepartmentID { get; set; }
        public Nullable<int> CourseID { get; set; }
        public Nullable<int> YearID { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string TotalMark { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public int IsDeleted { get; set; }
        public string Attachment { get; set; }

        public HttpPostedFileBase File { get; set; }
        public virtual AssesmentType AssesmentType { get; set; }
        public virtual Course Course { get; set; }
        public virtual Department Department { get; set; }
        public virtual Section Section { get; set; }
        public virtual Teacher Teacher { get; set; }
        public virtual Year Year { get; set; }
    }
}