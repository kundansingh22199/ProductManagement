using B2CAdmin.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace B2CAdmin
{
    public partial class Master : System.Web.UI.MasterPage
    {
        ClsUserMaster clsUser = new ClsUserMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MobileNo"] == null)
            {
                Response.Redirect("../Default.aspx");
            }
            if (!IsPostBack)
            {
                GetUserProfile();
            }
        }
        public void GetUserProfile()
        {
            int userid = Convert.ToInt32(Session["UserId"]);
            DataTable dt = clsUser.UserDetailsById(userid);
            if (dt.Rows.Count > 0)
            {
                profileImg.ImageUrl = dt.Rows[0]["UserImage"].ToString();
                Image1.ImageUrl = dt.Rows[0]["UserImage"].ToString();
                txtName.InnerText = dt.Rows[0]["UserName"].ToString();
                txtCompanyName.InnerText = dt.Rows[0]["CompanyName"].ToString();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            if (Session["MobileNo"] != null || Session["UserId"] != null || Session["UserType"] != null)
            {
                Session["MobileNo"] = null;
                Session["UserId"] = null;
                Session["UserType"] = null;
                Response.Redirect("../Default.aspx");
            }
           
        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }
    }
}