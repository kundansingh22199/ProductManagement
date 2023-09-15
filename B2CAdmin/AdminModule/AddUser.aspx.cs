using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using B2CAdmin.App_Code;

namespace B2CAdmin.AdminModule
{
    public partial class AddUser : System.Web.UI.Page
    {
        ClsUserMaster clsUser = new ClsUserMaster();
        int minsize = 20 * 1024; int maxsize = 3 * 1024 * 1024;
        int fileSize1 = 0, fileSize2 = 0, fileSize3 = 0, fileSize4 = 0;
        string fileName1 = "", fileName2 = "", fileName3 = "", fileName4 = "";
        bool status = true;
        int count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDLState();
                BindUserType();
                GetQueryStringValue();
            }
        }
        public void GetQueryStringValue()
        {
            string val = HttpContext.Current.Request.QueryString["Id"];
            if (!string.IsNullOrEmpty(val))
            {
                int Id = Convert.ToInt32(val);
                DataTable dt = clsUser.UserDetailsById(Id);
                if (dt.Rows.Count > 0)
                {
                    //txtUserId.Text = dt.Rows[0]["UserId"].ToString();
                    txtUserName.Text = dt.Rows[0]["UserName"].ToString();
                    ddlUserType.SelectedValue = dt.Rows[0]["UserType"].ToString();
                    txtAddress.Text = dt.Rows[0]["Address"].ToString();
                    txtAadhar.Text = dt.Rows[0]["AadharNo"].ToString();
                    txtPanCard.Text = dt.Rows[0]["PanNo"].ToString();
                    ddlState.SelectedValue = dt.Rows[0]["State"].ToString();
                    BindDDLCity();
                    ddlCity.SelectedValue = dt.Rows[0]["City"].ToString();
                    txtPinCode.Text = dt.Rows[0]["PinCode"].ToString();
                    txtGstIn.Text = dt.Rows[0]["GstinNo"].ToString();
                    txtMobileNo.Text = dt.Rows[0]["MobileNo"].ToString();
                    txtEmail.Text = dt.Rows[0]["Emailid"].ToString();
                    string DateofBirth = dt.Rows[0]["Dob"].ToString();
                    txtDob.Text = Convert.ToDateTime(DateofBirth).ToString("yyyy-MM-dd");
                    txtCompanyName.Text = dt.Rows[0]["CompanyName"].ToString();
                    txtStore.Text = dt.Rows[0]["StoreName"].ToString();
                    txtBranch.Text = dt.Rows[0]["BranchDetails"].ToString();

                    ViewState["UserId"] = dt.Rows[0]["UserId"].ToString();
                    ViewState["UserImage"] = dt.Rows[0]["UserImage"].ToString();
                    ViewState["Aadharimage"] = dt.Rows[0]["Aadharimage"].ToString();
                    ViewState["AddharImage2"] = dt.Rows[0]["AddharImage2"].ToString();
                    ViewState["PancardImage"] = dt.Rows[0]["PancardImage"].ToString();

                }
                btnSubmit.Visible = false;
                btnUpdate.Visible = true;
            }
            else
            {
                btnSubmit.Visible = true;
                btnUpdate.Visible = false;
            }
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

        public void BindUserType()
        {
            int userType = Convert.ToInt32(Session["UserType"]);
            DataTable dt = clsUser.GetUserType(userType);
            ddlUserType.DataSource = dt;
            ddlUserType.DataTextField = "UserType";
            ddlUserType.DataValueField = "Id";
            ddlUserType.DataBind();

            ListItem list = new ListItem("--Select--", "Selected");
            list.Selected = true;
            ddlUserType.Items.Insert(0, list);
        }
        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindDDLCity();
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (UserImage.HasFile)
            {
                fileSize1 = UserImage.PostedFile.ContentLength;
                if (fileSize1 > minsize & fileSize1 < maxsize)
                {
                    fileName1 = Path.GetFileName(UserImage.PostedFile.FileName);
                    UserImage.SaveAs(Server.MapPath("~/Images/" + fileName1));
                    fileName1 = "~/Images/" + fileName1;
                    status = checkexetion(UserImage);
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
                count++;
            }
            if (AddharImage.HasFile)
            {
                fileSize2 = AddharImage.PostedFile.ContentLength;
                if (fileSize2 > minsize & fileSize2 < maxsize)
                {
                    fileName2 = Path.GetFileName(AddharImage.PostedFile.FileName);
                    AddharImage.SaveAs(Server.MapPath("~/Images/" + fileName2));
                    fileName2 = "~/Images/" + fileName2;
                    status = checkexetion(AddharImage);
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
                count++;
            }
            if (AddharImage2.HasFile)
            {
                fileSize3 = AddharImage2.PostedFile.ContentLength;
                if (fileSize3 > minsize & fileSize3 < maxsize)
                {
                    fileName3 = Path.GetFileName(AddharImage2.PostedFile.FileName);
                    AddharImage2.SaveAs(Server.MapPath("~/Images/" + fileName3));
                    fileName3 = "~/Images/" + fileName3;
                    status = checkexetion(AddharImage2);
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
                count++;
            }
            if (PanImage.HasFile)
            {
                fileSize4 = PanImage.PostedFile.ContentLength;
                if (fileSize4 > minsize & fileSize4 < maxsize)
                {
                    fileName4 = Path.GetFileName(PanImage.PostedFile.FileName);
                    PanImage.SaveAs(Server.MapPath("~/Images/" + fileName4));
                    fileName4 = "~/Images/" + fileName4;
                    status = checkexetion(PanImage);
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
                count++;
            }

            if (status == true && count == 0)
            {
                Random random = new Random();
                string User = DateTime.Now.ToString("ddMMyyyy") + random.Next(1111111, 9999999).ToString();
                int userType = Convert.ToInt32(ddlUserType.SelectedValue);
                int userid = Convert.ToInt32(Session["UserId"]);
                DateTime Dob = Convert.ToDateTime(txtDob.Text);

                int State = Convert.ToInt32(ddlState.SelectedValue);
                int City = Convert.ToInt32(ddlCity.SelectedValue);
                int PinCode = Convert.ToInt32(txtPinCode.Text.Trim());
                string Password = random.Next(1111, 9999).ToString();
                string action = "Insert";

                DataTable dtUser = clsUser.UserDetailsByUserId(User);
                DataTable dtMobile = clsUser.UserDetailsByMobileNo(txtMobileNo.Text.Trim());
                DataTable dtEmail = clsUser.UserDetailsByEmail(txtEmail.Text.Trim());
                if (dtUser.Rows.Count > 0)
                {
                    messagebox.Visible = false;
                    messageboxerror.Visible = true;
                    errmsg.InnerText = "UserId Already Exixt Try Again";
                }
                else if(dtMobile.Rows.Count > 0)
                {
                    messagebox.Visible = false;
                    messageboxerror.Visible = true;
                    errmsg.InnerText = "Mobile No Already Exixt Try Again";
                }
                else if(dtEmail.Rows.Count > 0)
                {
                    messagebox.Visible = false;
                    messageboxerror.Visible = true;
                    errmsg.InnerText = "Email Id Already Exixt Try Again";
                }
                else
                {
                    int result = 0;
                    result = clsUser.InsertUpdateUser(User, txtUserName.Text.Trim(), txtMobileNo.Text.Trim(), txtEmail.Text.Trim(), txtCompanyName.Text.Trim(),
                    Password, userType, txtAddress.Text.Trim(), txtAadhar.Text.Trim(), txtPanCard.Text.Trim(), txtGstIn.Text.Trim(), fileName1,
                    fileName2, fileName3, fileName4, txtStore.Text.Trim(), txtBranch.Text.Trim(), Dob, State, City, PinCode, userid, action);

                    if (result > 0)
                    {
                        messagebox.Visible = true;
                        txtPass.InnerText = "\t Your User Id : " + User + " & Password is :" + Password;
                        messageboxerror.Visible = false;
                        Clear();
                    }
                    else
                    {
                        messagebox.Visible = false;
                        messageboxerror.Visible = true;
                    }
                }
            }
            else
            {
                messagebox.Visible = false;
                messageboxerror.Visible = true;
                errmsg.Visible = false;
            }
        }

        public void Clear()
        {
            txtUserName.Text = txtAddress.Text = txtAadhar.Text = txtPanCard.Text = txtPinCode.Text = txtGstIn.Text = txtMobileNo.Text = txtEmail.Text = txtDob.Text = txtCompanyName.Text = txtStore.Text = txtBranch.Text = "";
            ddlUserType.SelectedValue = ddlState.SelectedValue = ddlCity.SelectedValue = null;
            UserImage.Dispose();
            AddharImage.Dispose();
            AddharImage2.Dispose();
            PanImage.Dispose();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (UserImage.HasFile)
            {
                fileSize1 = UserImage.PostedFile.ContentLength;
                if (fileSize1 > minsize & fileSize1 < maxsize)
                {
                    fileName1 = Path.GetFileName(UserImage.PostedFile.FileName);
                    UserImage.SaveAs(Server.MapPath("~/Images/" + fileName1));
                    fileName1 = "~/Images/" + fileName1;
                    status = checkexetion(UserImage);
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
                fileName1 = ViewState["UserImage"].ToString();
            }
            if (AddharImage.HasFile)
            {
                fileSize2 = AddharImage.PostedFile.ContentLength;
                if (fileSize2 > minsize & fileSize2 < maxsize)
                {
                    fileName2 = Path.GetFileName(AddharImage.PostedFile.FileName);
                    AddharImage.SaveAs(Server.MapPath("~/Images/" + fileName2));
                    fileName2 = "~/Images/" + fileName2;
                    status = checkexetion(AddharImage);
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
                fileName2 = ViewState["Aadharimage"].ToString();
            }
            if (AddharImage2.HasFile)
            {
                fileSize3 = AddharImage2.PostedFile.ContentLength;
                if (fileSize3 > minsize & fileSize3 < maxsize)
                {
                    fileName3 = Path.GetFileName(AddharImage2.PostedFile.FileName);
                    AddharImage2.SaveAs(Server.MapPath("~/Images/" + fileName3));
                    fileName3 = "~/Images/" + fileName3;
                    status = checkexetion(AddharImage2);
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
                fileName3 = ViewState["AddharImage2"].ToString();
            }
            if (PanImage.HasFile)
            {
                fileSize4 = PanImage.PostedFile.ContentLength;
                if (fileSize4 > minsize & fileSize4 < maxsize)
                {
                    fileName4 = Path.GetFileName(PanImage.PostedFile.FileName);
                    PanImage.SaveAs(Server.MapPath("~/Images/" + fileName4));
                    fileName4 = "~/Images/" + fileName4;
                    status = checkexetion(PanImage);
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
                fileName4 = ViewState["PancardImage"].ToString();
            }

            if (status == true && count == 0)
            {
                string User = ViewState["UserId"].ToString();
                int userType = Convert.ToInt32(ddlUserType.SelectedValue);
                int userid = Convert.ToInt32(Session["UserId"]);
                DateTime Dob = Convert.ToDateTime(txtDob.Text);

                int State = Convert.ToInt32(ddlState.SelectedValue);
                int City = Convert.ToInt32(ddlCity.SelectedValue);
                int PinCode = Convert.ToInt32(txtPinCode.Text.Trim());
                Random random = new Random();
                string Password = "";
                string action = "Update";
                int result = 0;
                result = clsUser.InsertUpdateUser(User, txtUserName.Text.Trim(), txtMobileNo.Text.Trim(), txtEmail.Text.Trim(), txtCompanyName.Text.Trim(),
                Password, userType, txtAddress.Text.Trim(), txtAadhar.Text.Trim(), txtPanCard.Text.Trim(), txtGstIn.Text.Trim(), fileName1,
                fileName2, fileName3, fileName4, txtStore.Text.Trim(), txtBranch.Text.Trim(), Dob, State, City, PinCode, userid, action);

                if (result > 0)
                {
                    messagebox.Visible = true;
                    //txtPass.InnerText = "\t Your Password is :" + Password;
                    messagebox.InnerText = "User Update Sucessfull";
                    messageboxerror.Visible = false;
                    Clear();
                }
                else
                {
                    messagebox.Visible = false;
                    messageboxerror.Visible = true;
                }
            }
            else
            {
                messagebox.Visible = false;
                messageboxerror.Visible = true;
            }
        }
    }
}