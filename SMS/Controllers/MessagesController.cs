using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SMS.Models;

namespace SMS.Controllers
{
    [Authorize]
    public class MessagesController : Controller
    {
        private SMSEntities db = new SMSEntities();

        // GET: Messages
        public ActionResult Index(string show)
        {
            if (show == null)
            {
                show = "inbox";
            }
            string name = Session["Name"].ToString();
            int ID = Convert.ToInt32(Session["ID"]); 
            if (Session["RoleName"].ToString() == "Teachers")
            {
                //count unread messages
                int unRead = db.Messages.Count(x => (x.ToTeachers == ID) && x.Status == 1);
                Session["unRead"] = unRead;
                if(show=="outbox")
                {
                    var outBox = db.Messages.Where(m => m.From == name).Include(m => m.Student).Include(m => m.Student).Include(m => m.Teacher).Include(m => m.Teacher); ;
                    return View(outBox.ToList());
                }
                else if (show == "inbox")
                {
                    var inBox = db.Messages.Where(m => m.ToTeachers == ID).Include(m => m.Student).Include(m => m.Student).Include(m => m.Teacher).Include(m => m.Teacher); ;
                    return View(inBox.ToList());
                }
                else if (show == "all")
                {
                    var all = db.Messages.Where(m => m.ToTeachers == ID||m.From == name).Include(m => m.Student).Include(m => m.Student).Include(m => m.Teacher).Include(m => m.Teacher); ;
                    return View(all.ToList());
                }
                
            }
            if (Session["RoleName"].ToString() == "Students")
            {
            //count unread messages
            int unRead = db.Messages.Count(x => (x.ToStudents == ID) && x.Status == 1);
            Session["unRead"] = unRead;
            if(show=="outbox")
                {
                    var outBox = db.Messages.Where(m => m.From == name).Include(m => m.Student).Include(m => m.Student).Include(m => m.Teacher).Include(m => m.Teacher); ;
                    return View(outBox.ToList());
                }
            else if (show == "inbox")
                {
                var inBox = db.Messages.Where(m => m.ToStudents == ID).Include(m => m.Student).Include(m => m.Teacher);
                return View(inBox.ToList());
                }
            else if (show == "all")
                {
                    var inBox = db.Messages.Where(m => m.ToStudents == ID||m.From == name).Include(m => m.Student).Include(m => m.Student).Include(m => m.Teacher).Include(m => m.Teacher); ;
                    return View(inBox.ToList());
                }

            }
            var msg = db.Messages.Where(m => m.Status==99);//means no message
            return View(msg);
        }

        // GET: Messages/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Message message = db.Messages.Find(id);
            message.Status = 0;
            db.Entry(message).State = EntityState.Modified;
            db.SaveChanges();
            int ID = Convert.ToInt32(Session["ID"]);
            if (Session["RoleName"].ToString() == "Teachers")
            {
                //count unread messages
                int unRead = db.Messages.Count(x => (x.ToTeachers == ID) && x.Status == 1);
                Session["unRead"] = unRead;
            }
            else if (Session["RoleName"].ToString() == "Students")
            {
                int unRead = db.Messages.Count(x => (x.ToStudents == ID) && x.Status == 1);
                Session["unRead"] = unRead;
            }
                if (message == null)
            {
                return HttpNotFound();
            }
            return View(message);
        }

        // GET: Messages/Create
        public ActionResult Create()
        {
            if (Session["RoleName"].ToString() == "Teachers")
            {
                int id = Convert.ToInt32(Session["ID"]);
                var department = db.Teaches.Where(d => d.TeacherId == id).Select(td => td.DepartmentId).ToList();
                var year = db.Teaches.Where(d => d.TeacherId == id).Select(td => td.YearId);
                var section = db.Teaches.Where(d => d.TeacherId == id).Select(td => td.SectionId);
                IEnumerable<Student> student = null;
                foreach (var dept in department)
                {
                    student = db.Students.Where(s => s.DepartmentID == dept.Value);

                    foreach (var y in year)
                    {
                        student = student.Where(s => s.YearID == y.Value);
                        foreach (var s in section)
                        {
                            student = student.Where(x => x.YearID == s.Value);
                        }
                    }
                }
                if (student != null)
                {
                ViewBag.ToStudents = new SelectList(student, "SysId", "FullName");
                }
                else
                {
                ViewBag.ToStudents = new SelectList(db.Students.Where(x => x.FullName=="No Students"),"SysId","FullNama");
                }

                ViewBag.CreatedBy = new SelectList(db.Teachers, "SysId", "Id");
            }
            else if (Session["RoleName"].ToString() == "Students")
            {
                int deptID = Convert.ToInt32(Session["Department"]);
                int SecID = Convert.ToInt32(Session["Section"]);
                int YrID = Convert.ToInt32(Session["Year"]);

                ViewBag.CreatedBy = new SelectList(db.Students, "SysId", "Id");
                ViewBag.ToTeachers = new SelectList(db.Teaches.Where(c => c.DepartmentId == deptID && c.YearId == YrID && c.SectionId == SecID).Select(x => x.Teacher), "SysId", "FullName");
            
                return View();
            }
            return View();
        }

        // POST: Messages/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SysId,From,ToStudents,ToTeachers,Subject,Body,Status,SentDate,IsDeleted")] Message message)
        {
            if (ModelState.IsValid)
            {
                message.Status = 1;
                message.IsDeleted = 0;
                message.SentDate = DateTime.Now;
                db.Messages.Add(message);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            if(Session["RoleName"].ToString() == "Teachers")
            {
            ViewBag.ToStudents = new SelectList(db.Students, "SysId", "Id", message.ToStudents); 
            }
            else if(Session["RoleName"].ToString() == "Students")
            {
            ViewBag.ToTeachers = new SelectList(db.Teachers, "SysId", "Id", message.ToTeachers); 
            }

            return View(message);
        }

        // GET: Messages/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Message message = db.Messages.Find(id);
            if (message == null)
            {
                return HttpNotFound();
            }
            return View(message);
        }

        // POST: Messages/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Message message = db.Messages.Find(id);
            db.Messages.Remove(message);
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
