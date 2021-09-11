using SMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SMS.Controllers
{
    [Authorize(Roles ="Admin,Teachers,Students")]
    public class HomeController : Controller
    {
        private SMSEntities db = new SMSEntities();
        [Authorize(Roles ="Admin,Teachers")]
        public ActionResult Index()
        {
                //count unread messages
            int ID = Convert.ToInt32(Session["ID"]);
            if(Session["RoleName"]!=null)
            {
            if (Session["RoleName"].ToString() == "Teachers")
            {
                GetData();
            int unRead = db.Messages.Count(x => (x.ToTeachers == ID) && x.Status == 1);
            Session["unRead"] = unRead;
            }
            else
            {
                int unRead = db.Messages.Count(x => (x.ToStudents == ID) && x.Status == 1);
                Session["unRead"] = unRead;
            }
            }
            
            return View();
        }
        [Authorize(Roles ="Teachers")]
        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult GetData()
        {
            int ID = Convert.ToInt32(Session["ID"]);
            IEnumerable<Teach> teaches = db.Teaches.Where(x => x.TeacherId == ID);
            int totalStudents = 0;
            foreach(var dp in teaches)
            {
                int student = db.Students.Where(x => x.DepartmentID == dp.DepartmentId&&x.YearID==dp.YearId&&x.SectionID==dp.SectionId).Count();
                totalStudents += student;
            }            
            int courses = db.Teaches.Where(x => x.TeacherId == ID).Select(x=>x.CourseId).Count();
            int assesment = db.Assesments.Where(x => x.CreatedBy == ID).Count();
            int dept = db.Teaches.Where(x => x.TeacherId == ID).Select(x=>x.DepartmentId).Count();
            int section = db.Teaches.Where(x => x.TeacherId == ID).Select(x => x.SectionId).Count();
            int test = db.Assesments.Where(x => x.CreatedBy == ID&&x.AssesmentType.Name=="Test").Count();
            int assignment = db.Assesments.Where(x => x.CreatedBy == ID&&x.AssesmentType.Name=="Assignment").Count();
            int project = db.Assesments.Where(x => x.CreatedBy == ID&&x.AssesmentType.Name=="Project").Count();
            Report report = new Report();
            report.totalStudents = totalStudents;
            report.departments = dept;
            report.courses = courses;
            report.classes = section;
            report.assesments = assesment;
            report.tests = test;
            report.assignments = assignment;
            report.projects = project;
            ViewBag.totalStudents = totalStudents;
            ViewBag.departments = dept;
            ViewBag.courses = courses;
            ViewBag.classes = section;
            ViewBag.assesments = assesment;
            ViewBag.tests = test;
            return Json(report,JsonRequestBehavior.AllowGet);
        }

        public class Report
        {
            public int totalStudents { get; set; }
            public int departments { get; set; }
            public int courses { get; set; }
            public int classes { get; set; }
            public int assesments { get; set; }
            public int tests { get; set; }
            public int assignments { get; set; }
            public int projects { get; set; }
        }
    }
}