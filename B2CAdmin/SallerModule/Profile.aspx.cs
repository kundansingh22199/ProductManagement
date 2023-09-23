using B2CAdmin.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace B2CAdmin.SallerModule
{
    public partial class Profile : System.Web.UI.Page
    {
        ClsUserMaster clsUser = new ClsUserMaster();
        ClsProfileMaster clsProfile = new ClsProfileMaster();
        int minsize = 20 * 1024; int maxsize = 3 * 1024 * 1024;
        int fileSize1 = 0;
        string fileName1 = "";
        bool status = true;
        int count = 0;
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
                lblCity.InnerText = dt.Rows[0]["city_name"].ToString();
                lblState.InnerText = dt.Rows[0]["state_name"].ToString();
                lblPinCode.InnerText = dt.Rows[0]["PinCode"].ToString();
                ViewState["State"] = dt.Rows[0]["State"].ToString();
                ViewState["City"] = dt.Rows[0]["City"].ToString();
                UserImg.ImageUrl = dt.Rows[0]["UserImage"].ToString();
                //addharFrontImage.ImageUrl = dt.Rows[0]["Aadharimage"].ToString();
                //addharBackImage.ImageUrl = dt.Rows[0]["AddharImage2"].ToString();
                //panCardImage.ImageUrl = dt.Rows[0]["PancardImage"].ToString();
            }

        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            txtprofileName.InnerText = lblFullName.InnerText;
            txtUserType.InnerText = lblUserType.InnerText;
            profileId.InnerText = lblUserId.InnerText;
            profilePass.InnerText = lblPassword.InnerText;

            txtUserName.Text = lblFullName.InnerText;
            ddlGender.SelectedItem.Text = lblGender.InnerText;
            txtMobile.Text = lblPhone.InnerText;
            txtEmail.Text = lblEmail.InnerText;
            string dob = lblDob.InnerText;
            txtDob.Text = Convert.ToDateTime(dob).ToString("yyyy-MM-dd");
            txtPinCode.Text = lblPinCode.InnerText;
            txtAddress.Text = lblAddress.InnerText;
            //txtGstin.Text = dt.Rows[0]["GstinNo"].ToString();
            //txtAddhar.Text = dt.Rows[0]["AadharNo"].ToString();
            //txtPan.Text = dt.Rows[0]["PanNo"].ToString();
            //txtBranch.Text = dt.Rows[0]["BranchDetails"].ToString();
            //txtStore.Text = dt.Rows[0]["StoreName"].ToString();
            BindDDLState();
            ddlState.SelectedValue = ViewState["State"].ToString();
            BindDDLCity();
            ddlCity.SelectedValue = ViewState["City"].ToString();
            UserImage1.ImageUrl = UserImg.ImageUrl;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowPopup();", true);
        }
        public void BindDDLState()
        {
            DataTable dt = clsUser.GetStateData();
            ddlState.DataSource = dt;
            ddlState.DataTextField = "text";
            ddlState.DataValueField = "value";
            ddlState.DataBind();
        }

        public void BindDDLCity()
        {
            int StateId = Convert.ToInt32(ddlState.SelectedValue);
            DataTable dt = clsUser.GetCityData(StateId);
            ddlCity.DataSource = dt;
            ddlCity.DataTextField = "text";
            ddlCity.DataValueField = "value";
            ddlCity.DataBind();
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDLCity();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowPopup();", true);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int userid = Convert.ToInt32(Session["UserId"]);
            if (UserUpload.HasFile)
            {
                fileSize1 = UserUpload.PostedFile.ContentLength;
                if (fileSize1 > minsize & fileSize1 < maxsize)
                {
                    fileName1 = Path.GetFileName(UserUpload.PostedFile.FileName);
                    UserUpload.SaveAs(Server.MapPath("~/Images/" + fileName1));
                    fileName1 = "~/Images/" + fileName1;
                    status = checkexetion(UserUpload);
                    if (status == false)
                    {
                        count++;
                    }
                }
                else
                {
                    count++;
                }
            }
            else
            {
                fileName1 = UserImage1.ImageUrl;
            }
            if (status == true && count == 0)
            {
                int result = 0;
                result = clsProfile.UpdateProfile(txtUserName.Text.Trim(), txtMobile.Text.Trim(), txtEmail.Text.Trim(), txtAddress.Text.Trim(),
                    fileName1, txtDob.Text.Trim(), ddlGender.SelectedItem.Text.Trim(), Convert.ToInt32(ddlState.SelectedValue), Convert.ToInt32(ddlCity.SelectedValue),
                    txtPinCode.Text.Trim(), userid, userid);
                if (result > 0)
                {
                    GetUserById();
                    messagebox.Visible = true;
                    //txtPass.InnerText = "\t Your User Id : " + User + " & Password is :" + Password;
                    messageboxerror.Visible = false;
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "swal('Yeah!!', 'Admin Update Sucessfull', 'success')", true);
                }
                else
                {
                    messagebox.Visible = false;
                    messageboxerror.Visible = true;
                    errmsg.InnerText = "May Be Mobile No or Email Already Exixt Try Again";
                    //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "swal('Oops!!', 'Somthing is Wrong', 'error')", true);
                }
            }
        }
        public bool checkexetion(FileUpload FileUpl)
        {
            try
            {
                bool Status;

                string FileExt = Path.GetExtension(FileUpl.FileName);
                if (FileExt.ToUpper() == "PNG" || FileExt.ToUpper() == "JPG" || FileExt.ToUpper() == "JPEG" || FileExt.ToUpper() == ".JPEG" || FileExt.ToUpper() == ".JPG" || FileExt.ToUpper() == ".PNG")
                {
                    Status = true;
                }
                else
                {
                    Status = false;
                }

                return Status;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}