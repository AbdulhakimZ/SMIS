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

    public class SubmitAssignmentsController : Controller
    {
        private SMSEntities db = new SMSEntities();

        // GET: SubmitAssignments// is for teachers
        [Authorize(Roles = "Teachers")]
        public ActionResult Index(int? assesmentID)
        {            
            var submitAssignments = db.SubmitAssignments.Where(x => x.AssesmentId== assesmentID).Include(s => s.Assesment).Include(s => s.Student);
            return View(submitAssignments.ToList());
        }

        //
        // GET: jjjSubmitAssignments1/Create
        public ActionResult Create(int? assesmentID)
        {
            ViewBag.AssesmentId = assesmentID;// new SelectList(db.Assesments, "SysId", "Id");
            ViewBag.StudentId = new SelectList(db.Students, "SysId", "Id");
            return View();
        }

        // POST: jjjSubmitAssignments1/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SysId,StudentId,AssesmentId,FilePath,SubmissionDate")] SubmitAssignment submitAssignment)
        {
            if (ModelState.IsValid)
            {
                db.SubmitAssignments.Add(submitAssignment);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.AssesmentId = new SelectList(db.Assesments, "SysId", "Id", submitAssignment.AssesmentId);
            ViewBag.StudentId = new SelectList(db.Students, "SysId", "Id", submitAssignment.StudentId);
            return View(submitAssignment);
        }

        // GET: SubmitAssignments/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SubmitAssignment submitAssignment = db.SubmitAssignments.Find(id);
            if (submitAssignment == null)
            {
                return HttpNotFound();
            }
            return View(submitAssignment);
        }

        // GET: SubmitAssignments/Edit/5
        [Authorize(Roles = "Teachers,Admin")]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SubmitAssignment submitAssignment = db.SubmitAssignments.Find(id);
            if (submitAssignment == null)
            {
                return HttpNotFound();
            }
            ViewBag.AssesmentId = new SelectList(db.Assesments, "SysId", "Id", submitAssignment.AssesmentId);
            ViewBag.StudentId = new SelectList(db.Students, "SysId", "Id", submitAssignment.StudentId);
            return View(submitAssignment);
        }

        // POST: SubmitAssignments/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Teachers,Admin")]
        public ActionResult Edit([Bind(Include = "SysId,StudentId,AssesmentId,FilePath,SubmissionDate")] SubmitAssignment submitAssignment)
        {
            if (ModelState.IsValid)
            {
                db.Entry(submitAssignment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.AssesmentId = new SelectList(db.Assesments, "SysId", "Id", submitAssignment.AssesmentId);
            ViewBag.StudentId = new SelectList(db.Students, "SysId", "Id", submitAssignment.StudentId);
            return View(submitAssignment);
        }

        // GET: SubmitAssignments/Delete/5
        [Authorize(Roles = "Teachers,Admin")]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SubmitAssignment submitAssignment = db.SubmitAssignments.Find(id);
            if (submitAssignment == null)
            {
                return HttpNotFound();
            }
            return View(submitAssignment);
        }

        // POST: SubmitAssignments/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Teachers,Admin")]
        public ActionResult DeleteConfirmed(int id)
        {
            SubmitAssignment submitAssignment = db.SubmitAssignments.Find(id);
            db.SubmitAssignments.Remove(submitAssignment);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        //Upload Assignmnets for Students
        [HttpPost]
        [Authorize(Roles = "Students")]
        public ActionResult Upload(SubmitAssignmentModel membervalues)
        {
            string FileName = Path.GetFileNameWithoutExtension(membervalues.File.FileName);

            //To Get File Extension  
            string FileExtension = Path.GetExtension(membervalues.File.FileName);

            FileName = membervalues.StudentId + "-" + membervalues.AssesmentId+"-"+ FileName.Trim() + FileExtension;
             //maps server path automatically
            var path = Path.Combine(Server.MapPath("~/Content/SubmittedFiles/"), FileName);
            //Its Create complete path to store in server.   
            membervalues.FilePath = path;
            //To copy and save file into server.  
            membervalues.File.SaveAs(membervalues.FilePath);

            SubmitAssignment submitAssignment = new SubmitAssignment();
            submitAssignment.StudentId = membervalues.StudentId;
            submitAssignment.AssesmentId = membervalues.AssesmentId;
            submitAssignment.FilePath = membervalues.FilePath;
            String now = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");//make it datetime
            submitAssignment.SubmissionDate = DateTime.Parse(now);

            db.SubmitAssignments.Add(submitAssignment);
            db.SaveChanges();
            return RedirectToAction("AllAssignments", "CoursesStudent");
        }

        //Download Assignments For teachers
        [Authorize(Roles = "Teachers,Admin")]
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
