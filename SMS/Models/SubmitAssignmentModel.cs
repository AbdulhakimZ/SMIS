using SMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SMS.Models
{
    public class SubmitAssignmentModel
    {
        public int SysId { get; set; }
        public Nullable<int> StudentId { get; set; }
        public Nullable<int> AssesmentId { get; set; }
        public string FilePath { get; set; }
        public Nullable<System.DateTime> SubmissionDate { get; set; }

        public HttpPostedFileBase File { get; set; }
        public Assesment Assesment { get; set; }
        public Student Student { get; set; }
    }
}