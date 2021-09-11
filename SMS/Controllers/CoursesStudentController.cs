using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SMS.Models;

namespace SMS.Controllers
{
    [Authorize(Roles = "Students")]
    public class CoursesStudentController : Controller
    {
        private SMSEntities db = new SMSEntities();

        // GET: CoursesStudent
        public ActionResult Index()
        {
            //  int dept = Convert.ToInt32(Session["Department"]);
            //  int year = Convert.ToInt32(Session["Year"]);
            //  int id = Convert.ToInt32(Session["ID"]);
            // var courses = db.Courses.Include(c => c.Department).Include(c => c.Year);
            //var courses = db.Courses.Where(c => c.DepartmentID == dept && c.YearId == year).Include(c => c.Department).Include(c => c.Year);

            int ID = Convert.ToInt32(Session["ID"]);
            int unRead = db.Messages.Count(x => (x.ToStudents == ID) && x.Status == 1);
            Session["unRead"] = unRead;
            int deptID = Convert.ToInt32(Session["Department"]);
            int SecID = Convert.ToInt32(Session["Section"]);
            int YrID = Convert.ToInt32(Session["Year"]);
            IEnumerable<Course> courses = db.Teaches.Where(c => c.DepartmentId==deptID && c.YearId == YrID && c.SectionId == SecID ).Select(x => x.Course);
            return View(courses.ToList());
        }

        // GET: Returns Assesments which are found under specific cource
        public ActionResult AssesmentsUnderCourse(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            int dept = Convert.ToInt32(Session["Department"]);
            int year = Convert.ToInt32(Session["Year"]);
            String date = DateTime.Now.ToString("yyyy-MM-dd");
            DateTime today = DateTime.Parse(date);
            var assesments = db.Assesments.Where(a => a.CourseID == id && a.YearID==year && a.DepartmentID==dept && a.DeadLine >= today);
            if (assesments == null)
            {
                return HttpNotFound();
            }
            return View(assesments);
        }

        public ActionResult AllAssignments(string name)
        {
            ViewBag.Head = name+"s";
            int dept = Convert.ToInt32(Session["Department"]);
            int year = Convert.ToInt32(Session["Year"]);
            String date = DateTime.Now.ToString("yyyy-MM-dd");
            DateTime today = DateTime.Parse(date);
            var assesments = db.Assesments.Where(a => a.AssesmentType.Name == name && a.YearID == year && a.DepartmentID == dept && a.DeadLine >= today);
            if (assesments == null)
            {
                return HttpNotFound();
            }
            return View(assesments);
        }
        public ActionResult AllTests()
        {
            int dept = Convert.ToInt32(Session["Department"]);
            int year = Convert.ToInt32(Session["Year"]);
            String date = DateTime.Now.ToString("yyyy-MM-dd");
            DateTime today = DateTime.Parse(date);
            var assesments = db.Assesments.Where(a => a.AssesmentType.Name == "Test" && a.YearID == year && a.DepartmentID == dept && a.DeadLine >= today);
            if (assesments == null)
            {
                return HttpNotFound();
            }
            return View(assesments);
        }

        //Download Assesment Attachments For students
        public void Download(string filePath)
        {
            string fileName = Path.GetFileName(filePath);
            string path = Path.Combine(Server.MapPath("~/Content/SubmittedFiles/"), fileName);//map file on server
            FileInfo file = new FileInfo(path);
            if (file.Exists)
            {
                Response.Clear();

                Response.AppendHeader("content-disposition", "attachement; filename= " + fileName);
                Response.AddHeader("Content-Length", file.Length.ToString());
                Response.ContentType = "application/octet-stream";
                Response.WriteFile(path);
            }
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
