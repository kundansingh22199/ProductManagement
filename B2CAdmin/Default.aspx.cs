using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using B2CAdmin.App_Code;

namespace B2CAdmin
{
    public partial class Default : System.Web.UI.Page
    {
        ClsUserMaster user = new ClsUserMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["MobileNo"] = null;
            Session["UserId"] = null;
            Session["UserType"] = null;
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {

            //Session["MobileNo"] = txtUserId.Text;
            //Session["UserId"] = "1";
            //Response.Redirect("AdminModule/Dashboard.aspx");
            DataTable dt = user.UserLogin(txtUserId.Text.Trim(), txtPassword.Text.Trim());
            if (dt != null && dt.Rows.Count > 0)
            {
                Session["MobileNo"] = txtUserId.Text;
                Session["UserId"] = dt.Rows[0]["Id"].ToString();
                Session["User"] = dt.Rows[0]["UserId"].ToString();
                Session["UserType"] = dt.Rows[0]["UserType"].ToString();
                if (Convert.ToInt32(Session["UserType"]) == 1)
                {
                    Response.Redirect("AdminModule/Dashboard.aspx");
                }
                else
                {
                    Response.Redirect("SallerModule/DashBoard.aspx");
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "swal('Oops!!', 'Somthing is Wrong', 'error')", true);
            }
        }
    }
}