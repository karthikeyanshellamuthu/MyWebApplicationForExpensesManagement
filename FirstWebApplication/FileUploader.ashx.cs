using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FirstWebApplication
{
    /// <summary>
    /// Summary description for FileUploader
    /// </summary>
    public class FileUploader : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.Files.Count > 0)
            {
                HttpFileCollection files = context.Request.Files;
                for (int i = 0; i < files.Count; i++)
                {
                    HttpPostedFile file = files[i];
                    string fname = context.Server.MapPath("~/Upload Images/" + file.FileName);
                    file.SaveAs(fname);
                }
                context.Response.ContentType = "text/plain";
                context.Response.Write("File Uploaded Successfully!");
            }
    
            //if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE" || HttpContext.Current.Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
            //{
            //string[] testfiles = file.FileName.Split(new char[] { '\\' });
            //fname = testfiles[testfiles.Length - 1];
            //}
            //else
            //{
            //fname = file.FileName;
            //}
            //fname=Path.Combine(context.Server.MapPath("~/uploads/"), fname);
            //file.SaveAs(fname);
            //}

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}