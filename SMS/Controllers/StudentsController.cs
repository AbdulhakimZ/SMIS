using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SMS.Models;
using UserInterface.Controllers;

namespace SMS.Controllers
{
    [Authorize(Roles = "Teachers,Admin")]
    public class StudentsController : Controller
    {
        private SMSEntities db = new SMSEntities();

        // GET: Students
        public ActionResult Index()
        {
            int ID = Convert.ToInt32(Session["ID"]);
            int unRead = db.Messages.Count(x => (x.ToTeachers == ID) && x.Status == 1);
            Session["unRead"] = unRead;
            int id = Convert.ToInt32(Session["ID"]);
            var department = db.Teaches.Where(d => d.TeacherId == id).Select(td => td.DepartmentId).ToList();
            var year = db.Teaches.Where(d => d.TeacherId == id).Select(td => td.YearId);
            var section = db.Teaches.Where(d => d.TeacherId == id).Select(td => td.SectionId);
            IEnumerable<Student> student=null;
            //var students = db.Students.Include(s => s.Department).Include(s => s.Role1).Include(s => s.Section).Include(s => s.Teacher).Include(s => s.Year);
            if(Session["Role"].ToString() == "Admin")
            {
                 student = db.Students;
                return View(student.ToList());
            }

            foreach(var dept in department)
            {
                student= db.Students.Where(s => s.DepartmentID == dept.Value);

                foreach (var y in year)
                {
                    student = student.Where(s => s.YearID == y.Value);
                    foreach(var s in section)
                    {
                        student = student.Where(x => x.YearID == s.Value);
                    }
                }
            }
            // student = student.Include(s => s.Department).Include(s => s.Role1).Include(s => s.Section).Include(s => s.Teacher).Include(s => s.Year);
            if (student != null)
            {
                return View(student.ToList());
            }
            else
            {
                return View();
            }
            
        }

        // GET: Students/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Student student = db.Students.Find(id);
            if (student == null)
            {
                return HttpNotFound();
            }
            return View(student);
        }

        // GET: Students/Create
        public ActionResult Create()
        {
            int id = Convert.ToInt32(Session["ID"]); 
            if (Session["RoleName"].ToString() != "Admin")
            {
                ViewBag.DepartmentID = new SelectList(db.Teaches.Where(d => d.TeacherId == id).Select(td => td.Department), "SysId", "Name");
                ViewBag.SectionID = new SelectList(db.Teaches.Where(d => d.TeacherId == id).Select(td => td.Section), "SysId", "Value");
                ViewBag.YearID = new SelectList(db.Teaches.Where(d => d.TeacherId == id).Select(td => td.Year), "SysId", "Value");
            }
            else
            {
            ViewBag.DepartmentID = new SelectList(db.Departments, "SysId", "Name");
            ViewBag.SectionID = new SelectList(db.Sections, "SysId", "Value");
            ViewBag.YearID = new SelectList(db.Years, "SysId", "Value");
            }
            ViewBag.Role = new SelectList(db.Roles, "SysId", "Name");
            ViewBag.CreatedBy = new SelectList(db.Teachers, "SysId", "Id");

            return View();
        }

        // POST: Students/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SysId,Id,FirstName,LastName,FullName,UserName,Email,Phone,Password,SectionID,YearID,CreatedBy,IsDeleted,Role,Photo,DepartmentID")] Student student)
        {
            if (ModelState.IsValid)
            {
                CryptoHash cryptoHash = new CryptoHash();
                string salt = cryptoHash.CreateSalt(10);
                student.Password = cryptoHash.GenerateHash(student.Password, salt);

                Account account = new Account();
                account.Password = student.Password;
                account.Salt = salt;
                account.StudentID = student.SysId;
                account.RoleID = student.Role;
                account.IsDeleted = 0;//or isActive
                account.CreatedBy = Convert.ToInt32(Session["ID"]);

                db.Accounts.Add(account);
                db.Students.Add(student);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.DepartmentID = new SelectList(db.Departments, "SysId", "Name", student.DepartmentID);
            ViewBag.Role = new SelectList(db.Roles, "SysId", "Name", student.Role);
            ViewBag.SectionID = new SelectList(db.Sections, "SysId", "Value", student.SectionID);
            ViewBag.CreatedBy = new SelectList(db.Teachers, "SysId", "Id", student.CreatedBy);
            ViewBag.YearID = new SelectList(db.Years, "SysId", "Value", student.YearID);
            return View(student);
        }

        // GET: Students/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Student student = db.Students.Find(id);
            if (student == null)
            {
                return HttpNotFound();
            }
            ViewBag.DepartmentID = new SelectList(db.Departments, "SysId", "Name", student.DepartmentID);
            ViewBag.Role = new SelectList(db.Roles, "SysId", "Name", student.Role);
            ViewBag.SectionID = new SelectList(db.Sections, "SysId", "Value", student.SectionID);
            ViewBag.CreatedBy = new SelectList(db.Teachers, "SysId", "Id", student.CreatedBy);
            ViewBag.YearID = new SelectList(db.Years, "SysId", "Value", student.YearID);
            return View(student);
        }

        // POST: Students/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "SysId,Id,FirstName,LastName,FullName,UserName,Email,Phone,Password,SectionID,YearID,CreatedBy,IsDeleted,Role,Photo,DepartmentID")] Student student)
        {
            if (ModelState.IsValid)
            {
                db.Entry(student).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.DepartmentID = new SelectList(db.Departments, "SysId", "Name", student.DepartmentID);
            ViewBag.Role = new SelectList(db.Roles, "SysId", "Name", student.Role);
            ViewBag.SectionID = new SelectList(db.Sections, "SysId", "Value", student.SectionID);
            ViewBag.CreatedBy = new SelectList(db.Teachers, "SysId", "Id", student.CreatedBy);
            ViewBag.YearID = new SelectList(db.Years, "SysId", "Value", student.YearID);
            return View(student);
        }

        // GET: Students/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Student student = db.Students.Find(id);
            if (student == null)
            {
                return HttpNotFound();
            }
            return View(student);
        }

        // POST: Students/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            try
            {
            Student student = db.Students.Find(id);
            db.Students.Remove(student);
            db.SaveChanges();
            return RedirectToAction("Index");
            }catch(Exception e)
            {
                ModelState.AddModelError("","This student has ongoing sessions. Please end these sessions before delete");
                return View();
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
