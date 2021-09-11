using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using SMS.Models;

namespace SMS.Controllers
{
    public class Assesments1Controller : ApiController
    {
        private SMSEntities db = new SMSEntities();

        // GET: api/Assesments1
        public IQueryable<Assesment> GetAssesments()
        {
            return db.Assesments;
        }

        // GET: api/Assesments1/5
        [ResponseType(typeof(Assesment))]
        public IHttpActionResult GetAssesment(int id)
        {
            Assesment assesment = db.Assesments.Find(id);
            if (assesment == null)
            {
                return NotFound();
            }

            return Ok(assesment);
        }

        // PUT: api/Assesments1/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutAssesment(int id, Assesment assesment)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != assesment.SysId)
            {
                return BadRequest();
            }

            db.Entry(assesment).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AssesmentExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Assesments1
        [ResponseType(typeof(Assesment))]
        public IHttpActionResult PostAssesment(Assesment assesment)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Assesments.Add(assesment);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = assesment.SysId }, assesment);
        }

        // DELETE: api/Assesments1/5
        [ResponseType(typeof(Assesment))]
        public IHttpActionResult DeleteAssesment(int id)
        {
            Assesment assesment = db.Assesments.Find(id);
            if (assesment == null)
            {
                return NotFound();
            }

            db.Assesments.Remove(assesment);
            db.SaveChanges();

            return Ok(assesment);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool AssesmentExists(int id)
        {
            return db.Assesments.Count(e => e.SysId == id) > 0;
        }
    }
}