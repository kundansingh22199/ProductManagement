using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace B2CAdmin.Handlers
{
    /// <summary>
    /// Summary description for NewHandler
    /// </summary>
    public class NewHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Hello World");
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