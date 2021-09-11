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

    public class ResultsController : Controller
    {
        private SMSEntities db = new SMSEntities();

        // GET: Results
        [Authorize(Roles = "Teachers")]
        public ActionResult Index(int? id)
        {
            var results = db.Results.Where(r => r.AssessmentID==id).Include(r => r.Assesment).Include(r => r.Student).Include(r => r.Teacher);
            return View(results.ToList());
        }

        //Give result only for teachers
        [HttpPost]
        [Authorize(Roles = "Teachers")]
        public ActionResult Index(List<Result> resultList)
        {
            //     List<Result> resultList = new List<Result>();
            //   resultList = IEResult.ToList();
            if (Session["RoleName"] != null)
            {
                if (Session["RoleName"].ToString() == "Teachers")
                 {
                    if (ModelState.IsValid)
                    { 
                    foreach(Result s in resultList)
                    {
                        Result singleResult = db.Results.Where(m => m.StudentID == s.StudentID && m.AssessmentID == s.AssessmentID).SingleOrDefault();
                        if (singleResult != null)
                        {
                            singleResult.Mark = s.Mark;
                        }
                    }
                    db.SaveChanges();
                    ViewBag.Message = "1";
                        var results = db.Results.Include(r => r.Assesment).Include(r => r.Student).Include(r => r.Teacher);
                        return View( );
                    } 
                }
            } 
            ViewBag.Message = "0";
            var resultsg = db.Results.Include(r => r.Assesment).Include(r => r.Student).Include(r => r.Teacher);
            return View(resultsg.ToList()); 
            
        }

        //View Result Only for students
        [Authorize(Roles = "Students")]
        public ActionResult ViewResult()
        {
            int SID = Convert.ToInt32(Session["ID"]); 
            var results = db.Results.Where(r => r.StudentID==SID).Include(r => r.Assesment).Include(r => r.Student).Include(r => r.Teacher);
            return View(results.ToList());
        }

        // GET: Results/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Result result = db.Results.Find(id);
            if (result == null)
            {
                return HttpNotFound();
            }
            return View(result);
        }

        // GET: Results/Create
        [Authorize(Roles = "Teachers,Admin")]
        public ActionResult Create()
        {
            ViewBag.AssessmentID = new SelectList(db.Assesments, "SysId", "Id");
            ViewBag.StudentID = new SelectList(db.Students, "SysId", "Id");
            ViewBag.CreatedBy = new SelectList(db.Teachers, "SysId", "Id");
            return View();
        }

        // POST: Results/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Teachers,Admin")]
        public ActionResult Create([Bind(Include = "SysId,AssessmentID,StudentID,Mark,CreatedBy,IsDeleted")] Result result)
        {
            if (ModelState.IsValid)
            {
                db.Results.Add(result);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.AssessmentID = new SelectList(db.Assesments, "SysId", "Id", result.AssessmentID);
            ViewBag.StudentID = new SelectList(db.Students, "SysId", "Id", result.StudentID);
            ViewBag.CreatedBy = new SelectList(db.Teachers, "SysId", "Id", result.CreatedBy);
            return View(result);
        }

        // GET: Results/Edit/5
        [Authorize(Roles = "Teachers,Admin")]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Result result = db.Results.Find(id);
            if (result == null)
            {
                return HttpNotFound();
            }
            ViewBag.AssessmentID = new SelectList(db.Assesments, "SysId", "Id", result.AssessmentID);
            ViewBag.StudentID = new SelectList(db.Students, "SysId", "Id", result.StudentID);
            ViewBag.CreatedBy = new SelectList(db.Teachers, "SysId", "Id", result.CreatedBy);
            return View(result);
        }

        // POST: Results/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Teachers,Admin")]
        public ActionResult Edit([Bind(Include = "SysId,AssessmentID,StudentID,Mark,CreatedBy,IsDeleted")] Result result)
        {
            if (ModelState.IsValid)
            {
                db.Entry(result).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.AssessmentID = new SelectList(db.Assesments, "SysId", "Id", result.AssessmentID);
            ViewBag.StudentID = new SelectList(db.Students, "SysId", "Id", result.StudentID);
            ViewBag.CreatedBy = new SelectList(db.Teachers, "SysId", "Id", result.CreatedBy);
            return View(result);
        }

        // GET: Results/Delete/5
        [Authorize(Roles = "Teachers,Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Result result = db.Results.Find(id);
            if (result == null)
            {
                return HttpNotFound();
            }
            return View(result);
        }

        // POST: Results/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Teachers,Admin")]
        public ActionResult DeleteConfirmed(int id)
        {
            Result result = db.Results.Find(id);
            db.Results.Remove(result);
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
