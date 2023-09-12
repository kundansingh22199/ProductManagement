using B2CAdmin.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.HtmlControls;

namespace B2CAdmin.AdminModule
{
    public partial class UserList : System.Web.UI.Page
    {
        ClsUserMaster clsUser = new ClsUserMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UserLists();
            }
        }
        public void UserLists()
        {
            DataTable dt= clsUser.UserDetails();
            Repeater1.DataSource = dt;
            Repeater1.DataBind();

            Repeater2.DataSource = dt;
            Repeater2.DataBind();
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Label lblId = (Label)e.Item.FindControl("lblId");
            int Id = Convert.ToInt32(lblId.Text);
            if (e.CommandName == "Details")
            {
                DataTable dt = clsUser.UserDetailsById(Id);
                lblUserName.Text = dt.Rows[0]["UserName"].ToString();
                lblUserId.Text = dt.Rows[0]["UserId"].ToString();
                lblMobile.Text = dt.Rows[0]["MobileNo"].ToString();
                lblPassword.Text = dt.Rows[0]["Password"].ToString();
                lblEmail.Text = dt.Rows[0]["Emailid"].ToString();
                lblDob.Text = dt.Rows[0]["Dob"].ToString();
                lblCompany.Text = dt.Rows[0]["CompanyName"].ToString();
                lblUserType.Text = dt.Rows[0]["UserType"].ToString();
                lblAddress.Text = dt.Rows[0]["Address"].ToString();
                lblGstIn.Text = dt.Rows[0]["GstinNo"].ToString();
                lblAddharNo.Text = dt.Rows[0]["AadharNo"].ToString();
                lblPanNo.Text = dt.Rows[0]["PanNo"].ToString();
                lblBranchDetails.Text = dt.Rows[0]["BranchDetails"].ToString();
                lblStoreName.Text = dt.Rows[0]["StoreName"].ToString();
                lblCreateDate.Text = dt.Rows[0]["CreateOn"].ToString();
                //lblUpdateDate.Text = dt.Rows[0]["UpdateOn"].ToString();
                UserImage.ImageUrl = dt.Rows[0]["UserImage"].ToString();
                AddharImage.ImageUrl = dt.Rows[0]["Aadharimage"].ToString();
                AddharImage2.ImageUrl = dt.Rows[0]["AddharImage2"].ToString();
                PanImage.ImageUrl = dt.Rows[0]["PancardImage"].ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ShowPopup();", true);
            }
            if (e.CommandName == "Delete")
            {
                int result = clsUser.DeleteUserData(Id);
                if (result > 0)
                {
                    UserLists();
                }
                else
                {

                }
            }
            if (e.CommandName == "Update")
            {
                Response.Redirect("AddUser.aspx?Id=" + Id + "");
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            btn_close.Visible = false;
            btnPrint.Visible = false;
            Btn_back.Visible = false;
            StringWriter stringWrite = new StringWriter();
            HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            Page pg = new Page();
            pg.EnableEventValidation = false;
            HtmlForm frm = new HtmlForm();
            pg.EnableEventValidation = false;
            pg.Controls.Add(frm);
            frm.Attributes.Add("runat", "server");
            frm.Controls.Add(divmodel);
            pg.DesignerInitialize();
            pg.RenderControl(htmlWrite);
            string strHTML = stringWrite.ToString();
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.Write(strHTML);
            HttpContext.Current.Response.Write("<script>window.print();</script>");
            HttpContext.Current.Response.End();
        }

        protected void Btn_back_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserList.aspx");
        }

        protected void btnExportInExcel_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=RepeaterExport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            Repeater2.RenderControl(hw);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();



        }
    }
}