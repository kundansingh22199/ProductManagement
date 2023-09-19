using B2CAdmin.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace B2CAdmin.AdminModule
{
    public partial class Profile : System.Web.UI.Page
    {
        ClsUserMaster clsUser = new ClsUserMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetUserById();
            }
        }
        public void GetUserById()
        {
            int userid = Convert.ToInt32(Session["UserId"]);
            DataTable dt = clsUser.UserDetailsById(userid);
            if (dt.Rows.Count > 0)
            {
                lblFullName.InnerText = dt.Rows[0]["UserName"].ToString();
                lblName.InnerText = dt.Rows[0]["UserName"].ToString();
                lblUserType.InnerText = dt.Rows[0]["UserTypeName"].ToString();
                lblGender.InnerText = dt.Rows[0]["gender"].ToString();
                lblUserId.InnerText = dt.Rows[0]["UserId"].ToString();
                //lblMobile.InnerText = dt.Rows[0]["MobileNo"].ToString();
                lblPhone.InnerText = dt.Rows[0]["MobileNo"].ToString();
                lblPassword.InnerText = dt.Rows[0]["Password"].ToString();
                lblEmail.InnerText = dt.Rows[0]["Emailid"].ToString();
                lblDob.InnerText = dt.Rows[0]["Dob"].ToString();
                lblCompany.InnerText = dt.Rows[0]["CompanyName"].ToString();
                //lblUserType.Text = dt.Rows[0]["UserType"].ToString();
                lblAddress.InnerText = dt.Rows[0]["Address"].ToString();
                lblGstin.InnerText = dt.Rows[0]["GstinNo"].ToString();
                lblAddhar.InnerText = dt.Rows[0]["AadharNo"].ToString();
                lblPan.InnerText = dt.Rows[0]["PanNo"].ToString();
                lblBranch.InnerText = dt.Rows[0]["BranchDetails"].ToString();
                lblStore.InnerText = dt.Rows[0]["StoreName"].ToString();
                //lblCity.InnerText = dt.Rows[0]["city_name"].ToString();
                //lblState.InnerText = dt.Rows[0]["state_name"].ToString();
                //lblCreateDate.Text = dt.Rows[0]["CreateOn"].ToString();
                //lblUpdateDate.Text = dt.Rows[0]["UpdateOn"].ToString();
                UserImg.ImageUrl = dt.Rows[0]["UserImage"].ToString();
                addharFrontImage.ImageUrl = dt.Rows[0]["Aadharimage"].ToString();
                addharBackImage.ImageUrl = dt.Rows[0]["AddharImage2"].ToString();
                panCardImage.ImageUrl = dt.Rows[0]["PancardImage"].ToString();
            }

        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            int userid = Convert.ToInt32(Session["UserId"]);
            Response.Redirect("AddUser.aspx?Id=" + userid + "");
        }
    }
}