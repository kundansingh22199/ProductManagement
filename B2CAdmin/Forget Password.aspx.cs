using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using B2CAdmin.App_Code;

namespace B2CAdmin
{
    public partial class Forget_Password : System.Web.UI.Page
    {
        ClsUserMaster clsUser = new ClsUserMaster();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txtPassword.Text.Trim() == txtConfirmPassword.Text.Trim())
            {
                int result = clsUser.ForgetUserPassword(txtUserId.Text.Trim(), txtPassword.Text.Trim());
                if (result > 0)
                {
                    Response.Write("<script>alert('Password Changed')</script>");
                }
                else
                {
                    Response.Write("<script>alert('Not Changed')</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Password and Confirm Password Not Matched')</script>");
            }
        }
    }
}