using SMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SMS.Models;
using System.Web.Mvc;

namespace SMS.Controllers
{
    [Authorize(Roles = "Admin")]
    public class TeachesController : Controller
    {
        SMSEntities db = new SMSEntities();
        // GET: Teaches
        public ActionResult Index()
        {
            var teaches = db.Teaches; 
            return View(teaches.ToList());
        }
        public ActionResult Dashboard()
        {
            Session["totalDept"] = db.Departments.Count();
            Session["totalCourses"] = db.Courses.Count();
            Session["totalTeachers"] = db.Teachers.Count();
            Session["totalStudents"] = db.Students.Count();
            Session["totalClasses"] = db.Sections.Count();  
            return View();
        }
        //Get 
        public ActionResult Create()
        {
            ViewBag.DepartmentId = new SelectList(db.Departments, "SysId", "Name");
            ViewBag.YearId = new SelectList(db.Years, "SysId", "Value");
            ViewBag.SectionId = new SelectList(db.Sections, "SysId", "Value");
            ViewBag.StudentId = new SelectList(db.Students, "SysId", "FullName");
            ViewBag.TeacherId = new SelectList(db.Teachers, "SysId", "FullName");
            ViewBag.CourseId = new SelectList(db.Courses, "SysId", "Name");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SysId,YearId,SectionId,DepartmentId,TeacherId,CourseId")] BigTeachModel bigTeachModel)
        {
            Teach teach = new Teach();
                 int isAssigned = 0;
                isAssigned = db.Teaches.Where(s => s.TeacherId == bigTeachModel.TeacherId && s.DepartmentId ==bigTeachModel.DepartmentId && s.CourseId == bigTeachModel.CourseId && s.SectionId == bigTeachModel.SectionId && s.YearId==bigTeachModel.YearId).Count();
                if(!(isAssigned>0))//the teacher is not assigned
                {
                teach.TeacherId = bigTeachModel.TeacherId;
                teach.DepartmentId = bigTeachModel.DepartmentId;
                teach.CourseId = bigTeachModel.CourseId;
                teach.YearId = bigTeachModel.YearId;
                teach.SectionId = bigTeachModel.SectionId;
                db.Teaches.Add(teach);
                db.SaveChanges();
                }
                else
                {
                    ViewBag.Assigned = "The teacher is already assigned";
                    return Create();
                }
            return RedirectToAction("Index");
        }
        
        public ActionResult Revoke(int? id)
        {
            Teach teach = db.Teaches.Find(id);
            db.Teaches.Remove(teach);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}