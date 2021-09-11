using System;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Security;
using Microsoft.AspNet.Identity;
using SMS.Models;
using UserInterface.Controllers;

namespace SMS.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        private SMSEntities entities = new SMSEntities();
        CryptoHash cryptoHash = new CryptoHash();

        public AccountController()
        {
        }
        //
        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return PartialView();
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(Account model, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            Role role = new Role();
            Account account;
            bool verify = false;
            Role teacher = entities.Roles.Where(r => r.Name == "Teachers").FirstOrDefault();
            Role student = entities.Roles.Where(r => r.Name == "Students").FirstOrDefault();
            if (model.RoleID == teacher.SysId)
            {
                account = entities.Accounts.Where(x => x.Teacher.Id == model.Student.Id).FirstOrDefault();
                if(account!=null)
                {
                var inputPass = cryptoHash.GenerateHash(model.Password, account.Salt);
                verify = cryptoHash.AreEqual(model.Password, account.Password, account.Salt);
                }
               // account = entities.Accounts.Where( x => (x.Teacher.Id == model.Student.Id && x.Password == model.Password)).SingleOrDefault();
            }
            
            else if (model.RoleID == student.SysId)
            {
                //account= entities.Accounts.Where( x => (x.Student.Id == model.Student.Id && x.Password == model.Password)).SingleOrDefault();                
                account = entities.Accounts.Where(x => x.Student.Id == model.Student.Id).FirstOrDefault();
                if (account != null)
                {
                var inputPass = cryptoHash.GenerateHash(model.Password, account.Salt);
                verify = cryptoHash.AreEqual(model.Password, account.Password, account.Salt);
                } 

            }
            else
            {
                account = null;
            }
            if (verify == true)
            {             
                if(account.Role.Name == "Teachers")
                {
                    Session["Role"] = "Teachers";
                    Session["ID"] = account.TeacherID;
                    Session["TeacherSysID"] = account.Teacher.SysId;
                    Session["Name"] = account.Teacher.FullName;
                    Session["Photo"] = account.Teacher.Photo;
                    Session["RoleName"] = account.Role.Name;
                    Session["RoleID"] = account.Role.SysId;
                    FormsAuthentication.SetAuthCookie(account.Teacher.Id,false);
                    return RedirectToAction("Index", "Home");//teacher page
                }
                else if (account.Role.Name == "Students")
                {
                    Session["Role"] = "Students";
                    Session["ID"] = account.StudentID;
                    Session["Name"] = account.Student.FullName;
                    Session["Photo"] = account.Student.Photo;
                    Session["Year"] = account.Student.YearID;
                    Session["Section"] = account.Student.SectionID;
                    Session["Department"] = account.Student.DepartmentID;
                    Session["RoleName"] = account.Role.Name;
                    Session["RoleID"] = account.Role.SysId;
                    FormsAuthentication.SetAuthCookie(account.Student.Id, false);
                    return RedirectToAction("Index", "CoursesStudent");//to student page
                }
                else if (account.Role.Name == "Admin")
                 {
                    Session["Role"] = "Admin";
                    Session["ID"] = account.TeacherID;
                    Session["Name"] = account.Teacher.FullName;
                    Session["Photo"] = account.Teacher.Photo;
                    Session["RoleName"] = account.Role.Name;
                    Session["RoleID"] = account.Role.SysId;
                    FormsAuthentication.SetAuthCookie(account.Teacher.Id, false);
                    return RedirectToAction("Dashboard", "Teaches");//to Admin Page
                }
                else
                {
                    ModelState.AddModelError("", "Invalid login attempt.");
                    return RedirectToAction("Login", "Account");
                }

               // return RedirectToLocal(returnUrl);
            }
            else
            {
                ModelState.AddModelError("", "Invalid login attempt.");
                return View(model);
            }                        
        }

        //
        // POST: /Account/LogOff
        public void LogOff()
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            Session.Clear();
            Session.RemoveAll();

            // clear authentication cookie
            HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            cookie1.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie1);

            // clear session cookie (not necessary for your current problem but i would recommend you do it anyway)
            SessionStateSection sessionStateSection = (SessionStateSection)WebConfigurationManager.GetSection("system.web/sessionState");
            HttpCookie cookie2 = new HttpCookie(sessionStateSection.CookieName, "");
            cookie2.Expires = DateTime.Now.AddYears(-1);
            Response.Cookies.Add(cookie2);

            FormsAuthentication.RedirectToLoginPage();
            FormsAuthentication.SignOut();
            Session.Contents.RemoveAll();
            RedirectToAction("Index","Account");
        }

        //Change Password Teachers
        [Authorize]
        public ActionResult ChangePassword()
        {
            int TID = Convert.ToInt32(Session["ID"]);
            int role = Convert.ToInt32(Session["RoleID"]);
            Account account;
            if(Session["RoleName"].ToString()=="Teachers")//teacher
            {
                account = entities.Accounts.Where(x => x.TeacherID == TID).SingleOrDefault();
            }
            else if (Session["RoleName"].ToString() == "Students")
            {
                account = entities.Accounts.Where(x => x.StudentID == TID).SingleOrDefault();
            }
            return View();
        }

        [HttpPost]
        [Authorize]
        [ValidateAntiForgeryToken]
        public ActionResult ChangePassword([Bind(Include = "SysId,Previous,NewPassword,Confirm,Role")] ChangePasswordModel changePassword)
        {
            bool verify;
            if (changePassword.Role == "Teachers")
            {
                int TID = Convert.ToInt32(Session["ID"]);

          //      var inputPass = cryptoHash.GenerateHash(changePassword.Previous, account.Salt);

                if (changePassword.Confirm == changePassword.NewPassword)
                {
                Account account = entities.Accounts.Where(x => x.TeacherID == TID).SingleOrDefault();
                verify = cryptoHash.AreEqual(changePassword.Previous, account.Password, account.Salt);
                    if (verify)
                    {
                        string salt = cryptoHash.CreateSalt(10);
                        account.Password = cryptoHash.GenerateHash(changePassword.NewPassword, salt);
                        account.Salt = salt;
                        entities.Entry(account).State = EntityState.Modified;
                        entities.SaveChanges();
                        ViewBag.MessageSuccess = "Password changed successfully!";
                        return ChangePassword();
                    }
                    else
                    {
                        ViewBag.Message = "Previous password doesn't match! Please try again";
                    }
                }
                else
                {
                    ViewBag.Message = "Password and Confirm Doesn't match";
                    return ChangePassword();
                }
            }
            else if(changePassword.Role == "Students")
            {
                int SID = Convert.ToInt32(Session["ID"]);
                
                 if (changePassword.Confirm == changePassword.NewPassword)
                    {
                    Account account = entities.Accounts.Where(x => x.StudentID == SID).SingleOrDefault();
                    verify = cryptoHash.AreEqual(changePassword.Previous, account.Password, account.Salt);
                    if (verify)
                       {
                            string salt = cryptoHash.CreateSalt(10);
                            account.Password = cryptoHash.GenerateHash(changePassword.NewPassword, salt);
                            account.Salt = salt;
                            entities.Entry(account).State = EntityState.Modified;
                            entities.SaveChanges();
                            ViewBag.MessageSuccess = "Password changed successfully!";
                            return ChangePassword();                 
                       }
                    else
                    {
                        ViewBag.Message = "Previous password doesn't match! Please try again";
                    }
                  }
                 else
                  {
                      ViewBag.Message = "Password and Confirm Doesn't match";
                      return ChangePassword();
                  }
            }
            return View();
        }

        [AllowAnonymous]
        public ActionResult SuperAdminLogin(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return PartialView();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> SuperAdminLogin(Account model, string returnUrl)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            Account account = entities.Accounts.Where(x => (x.Teacher.Id == model.Student.Id && x.Password == model.Password && x.RoleID == 3)).SingleOrDefault();

            if(account!=null)
            {
                Session["Role"] = "Admin";
                Session["ID"] = account.TeacherID;  
                Session["RoleName"] = account.Role.Name;
                Session["RoleID"] = account.Role.SysId;
                FormsAuthentication.SetAuthCookie(account.Teacher.FullName, false);
                return RedirectToAction("Index", "Home");//teacher page
            }
            else
            {
                ModelState.AddModelError("", "Invalid login attempt.");
                return RedirectToAction("SuperAdminLogin", "Account");
            }
            
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Index", "Home");
        }    
    }
}