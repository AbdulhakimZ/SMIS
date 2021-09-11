using System;
using System.Collections.Generic;
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
    [Authorize(Roles ="Teachers,Admin")]
    public class AssesmentsController : Controller
    {
        private SMSEntities db = new SMSEntities();

        // GET: Assesments
        public ActionResult Index()
        {
            int id = Convert.ToInt32(Session["ID"]);
            var department = db.Teaches.Where(d => d.TeacherId == id).Select(td => td.DepartmentId).ToList();
            var year = db.Teaches.Where(d => d.TeacherId == id).Select(td => td.YearId);
            var section = db.Teaches.Where(d => d.TeacherId == id).Select(td => td.SectionId);
     //       var assesments = db.Assesments.Include(a => a.AssesmentType).Include(a => a.Course).Include(a => a.Department).Include(a => a.Section).Include(a => a.Year);
            IEnumerable<Assesment> assesments = null;
            foreach (var dept in department)
            {
                assesments = db.Assesments.Where(s => s.DepartmentID == dept.Value);

                foreach (var y in year)
                {
                    assesments = assesments.Where(s => s.YearID == y.Value);
                    foreach (var s in section)
                    {
                        assesments = assesments.Where(x => x.YearID == s.Value);
                    }
                }
            }
            if(assesments != null)
            {
                return View(assesments.ToList());
            }
            else
            {
                return View();
            }
            
        }
        // GET: Assesments/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Assesment assesment = db.Assesments.Find(id);
            if (assesment == null)
            {
                return HttpNotFound();
            }
            return View(assesment);
        }

        // GET: Assesments/Create
   

        //// POST: Assesments/Create
        //// To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        //// more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SysId,Id,Type,Time,GivenDate,DeadLine,SectionID,DepartmentID,CourseID,YearID,Title,Description,TotalMark,CreatedBy,IsDeleted")] Assesment assesment)
        {
            if (ModelState.IsValid)
            {
                //check whether selected department and yead takes that specific course
                int studCourse = db.Courses.Where(c => c.SysId == assesment.CourseID && c.YearId == assesment.YearID).Count();
                if (studCourse > 0)
                {
                    assesment.CreatedBy = Convert.ToInt32(Session["ID"]);
                    db.Assesments.Add(assesment);
                    db.SaveChanges();
                    List<Result> resultList = new List<Result>();
                    Result result = new Result();
                    List<Student> studentList = db.Students.Where(x => x.SectionID == assesment.SectionID && x.YearID == assesment.YearID && x.DepartmentID == assesment.DepartmentID).ToList();
                    foreach (Student student in studentList)
                    {
                        result.StudentID = student.SysId;
                        result.AssessmentID = assesment.SysId;
                        result.CreatedBy = Convert.ToInt32(Session["TeacherSysID"]);
                        db.Results.Add(result);
                        db.SaveChanges();
                    }
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.StudentCourse = "The Selected department or Year does not match with the selected course";                    
                }
            }

            ViewBag.Type = new SelectList(db.AssesmentTypes, "SysId", "Name", assesment.Type);
            ViewBag.CourseID = new SelectList(db.Courses, "SysId", "Name", assesment.CourseID);
            ViewBag.DepartmentID = new SelectList(db.Departments, "SysId", "Name", assesment.DepartmentID);
            ViewBag.SectionID = new SelectList(db.Sections, "SysId", "Value", assesment.SectionID);
            ViewBag.YearID = new SelectList(db.Years, "SysId", "Value", assesment.YearID);
            return View();
        }

        //upload assesment
        [HttpPost]
        public ActionResult UploadAttachment(AssesmentAttachmentsModel membervalues)
        {
            if(membervalues.File != null)
            {            
                string FileName = Path.GetFileNameWithoutExtension(membervalues.File.FileName);
                string FileExtension = Path.GetExtension(membervalues.File.FileName);
                FileName = FileName.Trim() + FileExtension;
                //maps server path automatically
                var path = Path.Combine(Server.MapPath("~/Content/SubmittedFiles/"), FileName);
                //Its Create complete path to store in server.   
                membervalues.Attachment = path;
                //To copy and save file into server.  
                membervalues.File.SaveAs(membervalues.Attachment);
            }
            Assesment assesment = new Assesment(); 
            assesment.AssesmentType = membervalues.AssesmentType;
            assesment.Attachment = membervalues.Attachment;
            assesment.Course = membervalues.Course;
            assesment.CourseID = membervalues.CourseID;
            assesment.CreatedBy = Convert.ToInt32(Session["ID"]);
            assesment.DeadLine = membervalues.DeadLine;
            assesment.Department = membervalues.Department;
            assesment.DepartmentID = membervalues.DepartmentID;
            assesment.Description = membervalues.Description;
            assesment.GivenDate = membervalues.GivenDate;
            assesment.Id = membervalues.Id;
            assesment.IsDeleted = membervalues.IsDeleted;
            assesment.Section = membervalues.Section;
            assesment.SectionID = membervalues.SectionID;
            assesment.Teacher = membervalues.Teacher;
            assesment.Time = membervalues.Time;
            assesment.Title = membervalues.Title;
            assesment.TotalMark = membervalues.TotalMark;
            assesment.Type = membervalues.Type;
            assesment.Year = membervalues.Year;
            assesment.YearID = membervalues.YearID;
          //  db.Assesments.Add(assesment);
          //  db.SaveChanges();
            if(Session["operation"].ToString() == "create")
            {
               return Create(assesment);
               // return RedirectToAction("Create", assesment);

            }
            else if (Session["operation"].ToString() == "edit")
            {
                return Edit(assesment);
            }
            
            return RedirectToAction("Index");
        }

        // GET: Assesments/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Assesment assesment = db.Assesments.Find(id);
            Session["AssesmentCreatedDate"] = assesment.GivenDate;
            Session["AssesmentDeadline"] = assesment.DeadLine;
            Session["AssesmentAttachement"] = assesment.Attachment;
            Session["AssesmentSysId"] = assesment.SysId;
            if (assesment == null)
            {
                return HttpNotFound();
            }
            ViewBag.Type = new SelectList(db.AssesmentTypes, "SysId", "Name", assesment.Type);
            ViewBag.CourseID = new SelectList(db.Courses, "SysId", "Name", assesment.CourseID);
            ViewBag.DepartmentID = new SelectList(db.Departments, "SysId", "Name", assesment.DepartmentID);
            ViewBag.SectionID = new SelectList(db.Sections, "SysId", "Value", assesment.SectionID);
            ViewBag.YearID = new SelectList(db.Years, "SysId", "Value", assesment.YearID);
            return View(assesment);
        }

        // POST: Assesments/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "SysId,Id,Type,Time,GivenDate,DeadLine,SectionID,DepartmentID,CourseID,YearID,Title,Description,TotalMark,CreatedBy,IsDeleted,Attachment")] Assesment assesment)
        {
            if (ModelState.IsValid)
            {
                assesment.CreatedBy = Convert.ToInt32(Session["ID"]);
                assesment.GivenDate = DateTime.Parse(Session["AssesmentCreatedDate"].ToString());
                assesment.SysId = Convert.ToInt32(Session["AssesmentSysId"].ToString());
                assesment.Id =  Session["AssesmentSysId"].ToString();
                if (assesment.Attachment==null)
                {
                    if(Session["AssesmentAttachement"]!=null)
                    {
                        assesment.Attachment = Session["AssesmentAttachement"].ToString();
                    }
                    
                }
                if(assesment.DeadLine == null)
                {
                    assesment.DeadLine = DateTime.Parse(Session["AssesmentDeadline"].ToString());
                }
                db.Entry(assesment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Type = new SelectList(db.AssesmentTypes, "SysId", "Name", assesment.Type);
            ViewBag.CourseID = new SelectList(db.Courses, "SysId", "Name", assesment.CourseID);
            ViewBag.DepartmentID = new SelectList(db.Departments, "SysId", "Name", assesment.DepartmentID);
            ViewBag.SectionID = new SelectList(db.Sections, "SysId", "Value", assesment.SectionID);
            ViewBag.YearID = new SelectList(db.Years, "SysId", "Value", assesment.YearID);
            return View(assesment);
        }

        // GET: Assesments/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Assesment assesment = db.Assesments.Find(id);
            if (assesment == null)
            {
                return HttpNotFound();
            }
            return View(assesment);
        }

        // POST: Assesments/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            List<SubmitAssignment> submitAssignments = db.SubmitAssignments.Where(sa => sa.AssesmentId == id).ToList() ;
            List<Result> results = db.Results.Where(r => r.AssessmentID == id).ToList();
            foreach (SubmitAssignment sa in submitAssignments)
            { 
                db.SubmitAssignments.Remove(sa);
                db.SaveChanges();
            }
            foreach (Result r in results)
            {
                db.Results.Remove(r);
                db.SaveChanges();
            }
            Assesment assesment = db.Assesments.Find(id);
            db.Assesments.Remove(assesment);
            db.SaveChanges();
            return RedirectToAction("Index");
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
