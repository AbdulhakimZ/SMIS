using System.Web;
using System.Web.Optimization;

namespace SMS
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/lib").Include(
                        "~/Scripts/jquery-{version}.js",
                        "~/Content/js/adminlte.min.js",
                        "~/Content/js/jquery-ui.min.js",
                        "~/Content/js/jquery.min.js",
                        "~/Scripts/jquery-3.3.1.min.js",
                        "~/Content/js/bootstrap.min.js",
                        "~/Scripts/respond.js",
                        "~/Scripts/datatables/jquery.datatables.min.js",
                        "~/Scripts/datatables/datatables.bootstrap.min.js",
                        "~/Scripts/main.js",
                        "~/Scripts/jquery.validate.min.js",
                        "~/Scripts/jquery.validate.unobtrusive.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at https://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/css/bootstrap.min.css",
                      "~/Content/css/_all-skins.min.css",
                      "~/Content/css/AdminLTE.min.css",
                      "~/Content/css/ionicons.min.css",
                      "~/Content/fonts/font-awesome.min.css",
                      "~/Content/datatables/css/dataTables.bootstrap.min.css",
                      "~/Content/DataTables/css/dataTables.bootstrap4.css",
                      "~/Content/Site.css"));
        }
    }
}
