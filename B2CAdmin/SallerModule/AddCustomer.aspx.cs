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
    public partial class AddCustomer : System.Web.UI.Page
    {
        ClsUserMaster clsUser = new ClsUserMaster();
        int minsize = 20 * 1024; int maxsize = 3 * 1024 * 1024;
        int fileSize1 = 0;
        string fileName1 = "";
        bool status = true;
        int count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDDLState();
                BindUserType();
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
            ddlUserType.DataTextField = "UserTypeName";
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
                fileName1="";
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