using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using B2CAdmin.App_Code;
using System.Drawing;
using System.Web.UI.WebControls;

namespace B2CAdmin.SallerModule
{
    public partial class OrderLists : System.Web.UI.Page
    {
        ClsOrderMaster clsOrder=new ClsOrderMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrderLists(0);
            }
        }
        public void BindOrderLists(int pagenumber)
        {
            try
            {
                string OrderBy = Session["UserId"].ToString();
                DataTable dt = clsOrder.GetOrderListByOrderId(OrderBy);
                if (dt.Rows.Count > 0)
                {
                    PagedDataSource pgitems = new PagedDataSource();
                    if (txtSearch.Text.Trim() == "")
                    {
                        pgitems.DataSource = dt.DefaultView;
                        pgitems.AllowPaging = true;
                    }
                    else
                    {
                        //DataTable dt1 = clsProduct.SearchProductBySearchText(txtSearch.Text.Trim());
                        //pgitems.DataSource = dt1.DefaultView;
                        //pgitems.AllowPaging = true;
                    }

                    //control page size from here 
                    pgitems.PageSize = 5;
                    pgitems.CurrentPageIndex = pagenumber;
                    if (pgitems.PageCount > 1)
                    {
                        rptPaging.Visible = true;
                        ArrayList pages = new ArrayList();
                        for (int i = 0; i <= pgitems.PageCount - 1; i++)
                        {
                            pages.Add((i + 1).ToString());
                        }
                        rptPaging.DataSource = pages;
                        rptPaging.DataBind();
                    }
                    else
                    {
                        rptPaging.Visible = false;
                    }
                    Repeater1.DataSource = pgitems;
                    Repeater1.DataBind();
                }
                else
                {
                    Repeater1.DataSource = null;
                    Repeater1.DataBind();
                }
            }
            catch
            {

            }
            finally
            {

            }
        }
        protected void rptPaging_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int pagenumber = Convert.ToInt32(e.CommandArgument) - 1;
            BindOrderLists(pagenumber);
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Cancle")
            {
                Label lblStatus = e.Item.FindControl("lblStatus") as Label;
                ViewState["Status"] = lblStatus.Text;
                ViewState["Id"] = e.CommandArgument;
                msg.InnerText = "Are You Sure? To Cancle This Order";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblStatus = e.Item.FindControl("lblStatus") as Label;
                Label btnPanding = e.Item.FindControl("btnPanding") as Label;
                Label btnSuccess = e.Item.FindControl("btnSuccess") as Label;
                Label btnReject = e.Item.FindControl("btnReject") as Label;
                if (lblStatus.Text.ToLower() == "pending")
                {
                    //lblStatus.ForeColor = Color.FromArgb(247,203,115);
                    btnPanding.Visible = true;
                    btnSuccess.Visible = false;
                    btnReject.Visible = false;
                }
                else if (lblStatus.Text.ToLower() == "approved")
                {
                    //lblStatus.ForeColor = Color.Green;
                    btnSuccess.Visible = true;
                    btnReject.Visible = false;
                    btnPanding.Visible = false;
                }
                else
                {
                    //lblStatus.ForeColor = Color.Red;
                    btnReject.Visible = true;
                    btnPanding.Visible = false;
                    btnSuccess.Visible = false;
                }
            }
        }

        protected void btnCancle_Click(object sender, EventArgs e)
        {
            int Id = Convert.ToInt32(ViewState["Id"]);
            string Status = ViewState["Status"].ToString();
            string userId = Session["UserId"].ToString();
            if (Status.ToLower() == "approved")
            {
                msg.InnerText = "Approved Status Can Not be Cancalled";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
            }
            else if(Status.ToLower() == "cancle")
            {
                msg.InnerText = "Order Already Cancle Cancalled";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
            }
            else
            {
                int result = clsOrder.UpdateOrderStatus(Id, "Cancle", userId);
                if (result > 0)
                {
                    BindOrderLists(0);
                    msgsuccess.InnerText = "Successfull Cancled";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#ConformationModel').modal();", true);
                }
                else
                {
                    msg.InnerText = "Somthing Wrong";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "myModal", "$('#AlertModel').modal();", true);
                }
            }
        }
    }
}